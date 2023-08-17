#!/bin/bash

# Run init-script with long timeout - and make it run in the background
/opt/mssql-tools/bin/sqlcmd -I -i init.sql &

# Start SQL server
/opt/mssql/bin/sqlservr
