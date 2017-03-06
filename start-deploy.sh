#!/bin/sh
docker build . -t registry.appuio.ch/vshn-demoapp1/users:latest
docker push registry.appuio.ch/vshn-demoapp1/users:latest
