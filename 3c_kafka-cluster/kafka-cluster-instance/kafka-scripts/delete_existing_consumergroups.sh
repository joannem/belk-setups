#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [existing-consumergroup-name]"
	exit 1
fi

docker exec broker \
	kafka-consumer-groups --bootstrap-server broker:9092 \
             --delete \
	     --group $1
