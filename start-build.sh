#!/bin/bash
docker run -t --volume "/opt/git/services/users:/app" shop-example-users-builder mix deps.get && MIX_ENV=prod mix release

