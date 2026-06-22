#!/bin/bash

# env_file doesn't expand variables, so resolve the password here
export MSSQL_SA_PASSWORD="${SA_PASSWORD}"
export SQLCMDPASSWORD="${SA_PASSWORD}"

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to accept connections before running init
until /opt/mssql-tools18/bin/sqlcmd -No -Q "SELECT 1" &>/dev/null; do
  sleep 2
done

# Run init script
/opt/mssql-tools18/bin/sqlcmd -No -i init.sql

# Keep container alive
wait
