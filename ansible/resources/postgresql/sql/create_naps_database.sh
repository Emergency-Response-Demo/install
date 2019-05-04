#! /bin/bash

export PGPASSWORD=$POSTGRESQL_PASSWORD

SCRIPT_DIR=''
pushd "$(dirname "$(readlink -f "$BASH_SOURCE")")" > /dev/null && {
    SCRIPT_DIR="$PWD"
    popd > /dev/null
}   

echo "creating naps database"

psql -h $POSTGRESQL_SERVICE -d $POSTGRESQL_DATABASE -U $POSTGRESQL_USER -w -c "grant all privileges on database ${POSTGRESQL_DATABASE} to ${POSTGRESQL_USER};"
psql -h $POSTGRESQL_SERVICE -d $POSTGRESQL_DATABASE -U $POSTGRESQL_USER -w < ${SCRIPT_DIR}/naps_emergency_response_ddl.sql