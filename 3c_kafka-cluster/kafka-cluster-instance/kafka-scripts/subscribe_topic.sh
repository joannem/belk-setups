#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage $0 [topic-name] [consumer-group-name]"
	exit 1
fi

docker exec broker \
	kafka-console-consumer --bootstrap-server broker:9092 \
	     --timeout-ms 60000 \
	     --group $2 \
             --topic $1
