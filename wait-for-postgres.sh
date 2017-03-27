#!/bin/sh
# wait-for-postgres.sh

set -e

# save db credentials to pgpass file
# such that the psql command can connect
echo "users-db:5432:users:users:secret" > ~/.pgpass
chmod 600 ~/.pgpass
export PGPASSFILE=~/.pgpass

host="$1"
shift
cmd="$@"

until psql -h "$host" -U "users"; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
