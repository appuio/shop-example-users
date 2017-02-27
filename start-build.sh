#!/bin/bash
docker run -t --volume "/opt/git/docs_users:/app" docs_users_build mix release

