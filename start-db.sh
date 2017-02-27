#!/bin/bash
docker run --name elixir-db -e POSTGRES_PASSWORD=secret -p "5432:5432" -d postgres
