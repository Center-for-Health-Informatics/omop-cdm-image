# omop-cdm-image

SQL Server 2022 with an empty OMOP CDM 5.4, plus the tools to load an Athena
vocabulary into it. Meant for development and test sources, e.g. Synthea data
loaded with [ETL-Synthea](https://github.com/Center-for-Health-Informatics/ETL-Synthea)
from the [HADES image](https://github.com/Center-for-Health-Informatics/ohdsi-hades-image).

On start the container creates, if missing (it never drops anything):

- database `DB_NAME`, with a **UTF-8 collation** (see below), in simple recovery
- schemas `cdm`, `synthea` (ETL staging), `results` and `temp`
- login `DB_LOGIN`, owner of the database
- optionally login `WEBAPI_LOGIN`: `SELECT` on `cdm`; read/write on `results`
  and `temp`; `CREATE TABLE`/`VIEW`. That is what OHDSI WebAPI needs and no more.
- the 39 CDM 5.4 tables in `cdm`, if that schema is empty

## Setup

```shell
cp sample.env local.env      # fill in DB_NAME, DB_LOGIN, DB_PW, SA_PASSWORD (+ WEBAPI_*)
VOCAB_PATH=~/athena-vocab docker compose up -d --build
```

### Apple `container`

```shell
container build -t omop-cdm .
container run -d --name omop-cdm --platform linux/amd64 --user 0 -m 6G \
  --env-file local.env -p 0.0.0.0:1433:1433 \
  -v omop-mssql:/var/opt/mssql -v ~/athena-vocab:/vocab:ro omop-cdm
```

- **`--platform linux/amd64`**: SQL Server 2022 is amd64-only. It runs under
  Rosetta on Apple silicon (CU27 verified); `azure-sql-edge` is not needed.
- **`--user 0`**: as its default user, SQL Server can't create its `/.system`
  directory under `container` (`0xC0000022 Access Denied`).

## Loading the vocabulary

Download from [Athena](https://athena.ohdsi.org/), unpack, mount at `/vocab`, then:

```shell
docker compose exec server load-vocab      # or: container exec omop-cdm load-vocab
```

All nine tables, about 130M rows for a broad download, load in roughly two
minutes. Each table's row count is printed; compare with `wc -l` less the
header. `CONCEPT_CPT4.csv` is ignored: run Athena's `cpt.sh` with a UMLS API key
first if you need CPT4.

After the ETL, add keys and indices (loading is faster without them):

```shell
docker compose exec server cdm-indexes
```

### Why the format files

SQL Server **on Linux** has no `BULK INSERT ... CODEPAGE` option, so it reads
Athena's UTF-8 files in a legacy code page: `Prévita` arrives as `PrÃ©vita`,
silently, in every non-ASCII name, and a name near 255 bytes can overflow its
column. The database collation is `Latin1_General_100_CI_AS_SC_UTF8`, so
`varchar` holds UTF-8, and `fmt/<TABLE>.xml` declares each text field's
collation as UTF-8 so `BULK INSERT` reads the bytes correctly.

`fmt/` and `sql/40-load-vocab.sql` are generated from `sql/10-cdm-tables.sql`:

```shell
tools/make-vocab-load.py [~/athena-vocab]   # with a path, checks CSV headers against the DDL
```

## Contents

| file | |
| --- | --- |
| `sql/00-database.sql` | database, schemas, logins (idempotent) |
| `sql/10-cdm-tables.sql` | CDM 5.4 tables |
| `sql/20-primary-keys.sql`, `sql/30-indices.sql` | applied by `cdm-indexes` |
| `sql/40-load-vocab.sql`, `fmt/` | vocabulary load (generated) |
| `sql/90-foreign-keys.sql` | not applied by anything; for reference |
| `scripts/` | entrypoint, `load-vocab`, `cdm-indexes` |

The DDL is OHDSI's [CDM 5.4 SQL Server DDL](https://github.com/OHDSI/CommonDataModel/tree/v5.4.0/inst/ddl/5.4/sql_server),
schema-qualified with a `$(CDM_SCHEMA)` sqlcmd variable. It quotes the reserved
column name `"offset"`, so it must run with `sqlcmd -I` (quoted identifiers on,
which is not sqlcmd's default); the scripts do.

## Usage

```shell
sqlcmd -S 127.0.0.1 -U "$DB_LOGIN" -P "$DB_PW" -d "$DB_NAME" -No -Q "SELECT COUNT(*) FROM cdm.concept"
```

## References

* [Microsoft SQL Server - Ubuntu based images](https://hub.docker.com/_/microsoft-mssql-server)
* [SQL Server DDLs for CDM 5.4](https://github.com/OHDSI/CommonDataModel/tree/v5.4.0/inst/ddl/5.4/sql_server)
* [Format files to import UTF-8 data](https://learn.microsoft.com/en-us/sql/relational-databases/import-export/use-a-format-file-to-bulk-import-data-sql-server)
