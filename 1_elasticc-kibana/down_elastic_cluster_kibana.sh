#!/bin/bash

cd $(dirname $0)

docker compose down -v
docker network rm monitoring_network
