-include makefile.setup

PWD=$(shell pwd)
DB_SRC=${PWD}/db
DB_SCHEMA=schema.sql
DB_DATA=test_data.sql

analyze-all: analyze analyze-hints

analyze:
	@(dartanalyzer --no-hints --fatal-warnings bin/*.dart)

analyze-hints:
	@echo "! (dartanalyzer bin/*.dart | grep '^\[')" | bash

dependency:
	pub get

upgrade-dependency:
	pub upgrade

install_db:
	PGOPTIONS='--client-min-messages=warning' psql ${PGARGS} --dbname=${PGDB} --file=${DB_SRC}/${DB_SCHEMA} --host=${PGHOST} --username=${PGUSER} -w

install_db_test_data:
	LANG=C.UTF-8 PGOPTIONS='--client-min-messages=warning' psql ${PGARGS} --dbname=${PGDB} --file=${DB_SRC}/${DB_DATA} --host=${PGHOST} --username=${PGUSER} -w

latest_db_install:
	psql -c "SELECT pid, (SELECT pg_terminate_backend(pid)) as killed from pg_stat_activity WHERE datname = '${PGDB}'" --host=${PGHOST} --username=${PG_SUPER_USER} -w;
	-psql -c "DROP DATABASE ${PGDB};" --host=${PGHOST} --username=${PG_SUPER_USER} -w
	psql -c "CREATE DATABASE ${PGDB} WITH OWNER = ${PGUSER} ENCODING='UTF8' LC_COLLATE='en_DK.UTF-8' LC_CTYPE='en_DK.UTF-8' TEMPLATE = template0;" --host=${PGHOST} --username=${PG_SUPER_USER} -w
	PGOPTIONS='--client-min-messages=warning' psql ${PGARGS} --dbname=${PGDB} --file=${DB_SRC}/${DB_SCHEMA} --host=${PGHOST} --username=${PGUSER} -w
	LANG=C.UTF-8 PGOPTIONS='--client-min-messages=warning' psql ${PGARGS} --dbname=${PGDB} --file=${DB_SRC}/${DB_DATA} --host=${PGHOST} --username=${PGUSER} -w

