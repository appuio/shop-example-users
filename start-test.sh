#!/bin/bash
docker-compose -f docker-compose.dev.yml up -d
docker-compose exec users /bin/sh -c "export MIX_ENV=test;mix deps.get;/bin/sh"
