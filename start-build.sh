#!/bin/bash
docker run -t --volume "/opt/git/services/users:/app" shop-example-users-builder mix deps.get && mix release

