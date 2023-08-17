# omop-cdm-image
Docker image of a SQL Server-based instance of the OMOP Common Data Model

Currently uses CDM version 5.4

## Installation

1. Clone this repository.
```shell
> git clone git@github.com:Center-for-Health-Informatics/omop-cdm-image.git
```
2. Copy the sample environment file
```shell
> cp sample.env local.env
```
3. Edit `local.env` with values for:

variable | value
--- | ---
DB_NAME | name for the database to be created
DB_LOGIN | the name to be used to login to the database
DB_PW | the password associated with the login name
SA_PASSWORD | a password to assign to the server `SA` user.

Retain, but do not edit these two lines:
```
MSSQL_SA_PASSWORD=$SA_PASSWORD
SQLCMDPASSWORD=$SA_PASSWORD
```

4. Start a container using this image.
```shell
> docker compose up -d
```
## Usage

connect to the container IP on port 1433 using the credentials specified in `local.env`.

```shell
> sqlcmd -S "127.0.0.1" -U rri -P "SomeGreatPassword[3.14159265]" -No
1> SELECT * from PERSON;
2> GO
person_id   gender_concept_id year_of_birth month_of_birth day_of_birth birth_datetime          race_concept_id ethnicity_concept_id location_id provider_id care_site_id person_source_value                                gender_source_value                                gender_source_concept_id race_source_value                                  race_source_concept_id ethnicity_source_value                             ethnicity_source_concept_id
----------- ----------------- ------------- -------------- ------------ ----------------------- --------------- -------------------- ----------- ----------- ------------ -------------------------------------------------- -------------------------------------------------- ------------------------ -------------------------------------------------- ---------------------- -------------------------------------------------- ---------------------------

(0 rows affected)
1>
```
## References
* [Microsoft SQL Server - Ubuntu based images](https://hub.docker.com/_/microsoft-mssql-server)
* [SQL Server DDLs for CDM 5.4](https://github.com/OHDSI/CommonDataModel/tree/v5.4.0/inst/ddl/5.4/sql_server)
* [A short recipe for setting up the Microsoft SQL Server docker image](https://augustl.com/blog/2019/sql_server_docker_image_recipe/)
