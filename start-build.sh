#!/bin/bash
docker build ../users-builder -t shop-example-users-builder
docker run -t -e "DB_USERNAME=users" -e "DB_PASSWORD=secret" -e "DB_DATABASE=users" -e "DB_HOSTNAME=users-db" --volume "/opt/git/services/users:/app" shop-example-users-builder /bin/sh -c "mix clean --deps;mix deps.get;PORT=4000 MIX_ENV=prod mix release"
