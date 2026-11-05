#!/bin/bash
# Start SQL Server, then create the database, schemas, logins and (if the CDM
# schema is empty) the CDM tables. Safe on every start: nothing is dropped.
set -euo pipefail
. /opt/omop/scripts/omop-env.sh

/opt/mssql/bin/sqlservr &
SQLSERVR=$!
# Pass stop signals on so SQL Server shuts down cleanly.
trap 'kill -TERM "$SQLSERVR"; wait "$SQLSERVR"' TERM INT

until omop_sql -Q "SELECT 1" >/dev/null 2>&1; do
  kill -0 "$SQLSERVR" 2>/dev/null || { echo "omop: sqlservr exited" >&2; exit 1; }
  sleep 2
done

omop_sql -i "$OMOP/sql/00-database.sql"

TABLES=$(omop_sql -d "$DB_NAME" -h -1 -W -Q \
  "SET NOCOUNT ON; SELECT COUNT(*) FROM sys.tables WHERE schema_id = SCHEMA_ID('$CDM_SCHEMA')")
if [[ "$TABLES" == 0 ]]; then
  echo "omop: creating CDM 5.4 tables in ${DB_NAME}.${CDM_SCHEMA}"
  omop_sql -d "$DB_NAME" -i "$OMOP/sql/10-cdm-tables.sql"
else
  echo "omop: ${DB_NAME}.${CDM_SCHEMA} already has ${TABLES} tables"
fi
echo "omop: ready"

wait "$SQLSERVR"
