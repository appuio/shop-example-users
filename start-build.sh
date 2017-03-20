#!/bin/bash
docker run -it --rm --volume "/opt/git/services/users:/app" shop-example-users-builder:centos bash # mix clean --deps && mix deps.get && MIX_ENV=prod mix release

