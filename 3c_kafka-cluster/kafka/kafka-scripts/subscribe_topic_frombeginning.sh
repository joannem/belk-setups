#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [topic-name]"
	exit 1
fi

docker exec broker \
	kafka-console-consumer --bootstrap-server broker:9092 \
	     --timeout-ms 5000 \
             --topic $1 \
	     --offset earliest --partition 0
