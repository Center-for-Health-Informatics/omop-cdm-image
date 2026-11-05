# Shared settings for the image's scripts. Sourced, not run.

export MSSQL_SA_PASSWORD="${SA_PASSWORD:?SA_PASSWORD is required}"
export SQLCMDPASSWORD="${SA_PASSWORD}"

: "${DB_NAME:?DB_NAME is required}"
: "${DB_LOGIN:?DB_LOGIN is required}"
: "${DB_PW:?DB_PW is required}"
CDM_SCHEMA=${CDM_SCHEMA:-cdm}
ETL_SCHEMA=${ETL_SCHEMA:-synthea}
RESULTS_SCHEMA=${RESULTS_SCHEMA:-results}
TEMP_SCHEMA=${TEMP_SCHEMA:-temp}
# sqlcmd treats an empty variable as undefined, so "-" stands for "none".
WEBAPI_LOGIN=${WEBAPI_LOGIN:--}
WEBAPI_PW=${WEBAPI_PW:--}
VOCAB_DIR=${VOCAB_DIR:-/vocab}

OMOP=/opt/omop

# sqlcmd as SA with quoted identifiers on (-I: the CDM DDL quotes "offset") and
# every setting available as a scripting variable.
omop_sql() {
  /opt/mssql-tools18/bin/sqlcmd -No -b -I \
    -v DB_NAME="$DB_NAME" DB_LOGIN="$DB_LOGIN" DB_PW="$DB_PW" \
       CDM_SCHEMA="$CDM_SCHEMA" ETL_SCHEMA="$ETL_SCHEMA" \
       RESULTS_SCHEMA="$RESULTS_SCHEMA" TEMP_SCHEMA="$TEMP_SCHEMA" \
       WEBAPI_LOGIN="$WEBAPI_LOGIN" WEBAPI_PW="$WEBAPI_PW" \
       VOCAB_DIR="$VOCAB_DIR" FMT_DIR="$OMOP/fmt" \
    "$@"
}
