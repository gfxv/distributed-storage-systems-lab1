#!/bin/bash

DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="postgres"
DB_USER="postgres"

SQL_SCRIPT="procedure.sql"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <schema_name>"
    echo "Example: $0 test_schema1"
    exit 1
fi

SCHEMA_NAME="$1"

if ! command -v psql &> /dev/null; then
    echo "Error: psql is not installed or not found in PATH."
    exit 1
fi

psql -h $DB_HOST -d $DB_NAME -U "$DB_USER" -p $DB_PORT -t -A -f $SQL_SCRIPT 2>&1 >/dev/null

SQL="CALL rename_columns_in_schema('$SCHEMA_NAME');"
psql -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" \
     -c "$SQL" 2>&1 | grep "NOTICE" | sed 's/NOTICE: //'

if [ $? -ne 0 ]; then
    echo "Error: Failed to execute procedure for schema '$SCHEMA_NAME'."
    exit 1
fi
