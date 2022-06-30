#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [new-topic-name]"
	exit 1
fi

docker exec broker \
	kafka-topics --bootstrap-server broker:9092 \
             --create \
             --topic $1
