#!/bin/bash

docker exec broker \
	kafka-consumer-groups --bootstrap-server broker:9092 \
             --describe \
	     --all-groups
docker exec broker \
	kafka-consumer-groups --bootstrap-server broker:9092 \
             --describe --state \
	     --all-groups
