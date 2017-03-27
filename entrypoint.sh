#!/bin/sh

set -e

# TODO: check if necessary env. variables are set

# if no port is set, use default for postgres
DB_PORT=${DB_PORT:-5432}

# save db credentials to pgpass file
# such that the psql command can connect
echo "$DB_HOSTNAME:$DB_PORT:$DB_DATABASE:$DB_USERNAME:$DB_PASSWORD" > ~/.pgpass
chmod 600 ~/.pgpass
export PGPASSFILE=~/.pgpass

# sleep as long as postgres is not ready yet
until psql -h "$DB_HOSTNAME" -U "$DB_USERNAME"; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# as soon as postgres is up, execute the application with given params
>&2 echo "Postgres is up - executing command"
exec "$@"
