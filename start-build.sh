#!/bin/bash
docker run -t --volume "/opt/git/services/users:/app" docs_users_build mix deps.get && mix release

