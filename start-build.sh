#!/bin/bash
docker run -it --rm --volume "/opt/git/services/users:/app" shop-example-users-builder:latest mix clean --deps && mix deps.get && MIX_ENV=prod mix release

