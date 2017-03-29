#!/bin/bash
docker build ../users-builder -t shop-example-users-builder
docker run -t --volume "/opt/git/services/users:/app/source" shop-example-users-builder /bin/sh -c "mix clean --deps;mix deps.get;MIX_ENV=prod mix release --env=prod"
