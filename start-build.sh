#!/bin/bash
docker run -t --volume "/opt/git/services/users:/app" shop-example-users-builder /bin/sh -c "mix clean --deps;mix deps.get;MIX_ENV=prod mix release"
