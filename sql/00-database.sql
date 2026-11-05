-- Database, schemas and logins. Idempotent: creates what is missing, never
-- drops or alters what exists, so it is safe to run on every container start.
--
-- sqlcmd variables (entrypoint.sh supplies them from the environment):
--   DB_NAME, DB_LOGIN, DB_PW        database and its owner login
--   CDM_SCHEMA                      CDM tables and vocabulary
--   ETL_SCHEMA                      staging for an ETL's native tables (e.g. Synthea)
--   RESULTS_SCHEMA, TEMP_SCHEMA     for OHDSI tools (WebAPI, Achilles)
--   WEBAPI_LOGIN, WEBAPI_PW         optional least-privilege login for WebAPI;
--                                   skipped when WEBAPI_LOGIN is empty

IF DB_ID('$(DB_NAME)') IS NULL
BEGIN
  -- UTF-8 collation, so varchar columns hold the vocabulary's UTF-8 text as-is.
  -- SQL Server on Linux has no BULK INSERT CODEPAGE option; with a legacy
  -- collation every non-ASCII concept name would be silently mangled.
  EXEC('CREATE DATABASE [$(DB_NAME)] COLLATE Latin1_General_100_CI_AS_SC_UTF8');
  -- Bulk loads of the vocabulary would otherwise grow the log by many GB.
  EXEC('ALTER DATABASE [$(DB_NAME)] SET RECOVERY SIMPLE');
END
GO

USE [$(DB_NAME)];
GO

IF SCHEMA_ID('$(CDM_SCHEMA)') IS NULL EXEC('CREATE SCHEMA [$(CDM_SCHEMA)]');
IF SCHEMA_ID('$(ETL_SCHEMA)') IS NULL EXEC('CREATE SCHEMA [$(ETL_SCHEMA)]');
IF SCHEMA_ID('$(RESULTS_SCHEMA)') IS NULL EXEC('CREATE SCHEMA [$(RESULTS_SCHEMA)]');
IF SCHEMA_ID('$(TEMP_SCHEMA)') IS NULL EXEC('CREATE SCHEMA [$(TEMP_SCHEMA)]');
GO

-- Owner login: full control of the database (ETL, DDL, loading).
IF SUSER_ID('$(DB_LOGIN)') IS NULL
  EXEC('CREATE LOGIN [$(DB_LOGIN)] WITH PASSWORD = ''$(DB_PW)'', DEFAULT_DATABASE = [$(DB_NAME)]');
IF USER_ID('$(DB_LOGIN)') IS NULL
BEGIN
  EXEC('CREATE USER [$(DB_LOGIN)] FOR LOGIN [$(DB_LOGIN)] WITH DEFAULT_SCHEMA = [$(CDM_SCHEMA)]');
  EXEC('ALTER ROLE db_owner ADD MEMBER [$(DB_LOGIN)]');
END
GO

-- WebAPI login: read-only on the CDM and vocabulary, write only on results
-- and temp, as WebAPI needs.
IF '$(WEBAPI_LOGIN)' NOT IN ('', '-')
BEGIN
  IF SUSER_ID('$(WEBAPI_LOGIN)') IS NULL
    EXEC('CREATE LOGIN [$(WEBAPI_LOGIN)] WITH PASSWORD = ''$(WEBAPI_PW)'', DEFAULT_DATABASE = [$(DB_NAME)]');
  IF USER_ID('$(WEBAPI_LOGIN)') IS NULL
    EXEC('CREATE USER [$(WEBAPI_LOGIN)] FOR LOGIN [$(WEBAPI_LOGIN)] WITH DEFAULT_SCHEMA = [$(RESULTS_SCHEMA)]');
  EXEC('GRANT SELECT ON SCHEMA::[$(CDM_SCHEMA)] TO [$(WEBAPI_LOGIN)]');
  EXEC('GRANT SELECT, INSERT, UPDATE, DELETE, ALTER, REFERENCES ON SCHEMA::[$(RESULTS_SCHEMA)] TO [$(WEBAPI_LOGIN)]');
  EXEC('GRANT SELECT, INSERT, UPDATE, DELETE, ALTER, REFERENCES ON SCHEMA::[$(TEMP_SCHEMA)] TO [$(WEBAPI_LOGIN)]');
  EXEC('GRANT CREATE TABLE, CREATE VIEW TO [$(WEBAPI_LOGIN)]');
END
GO

