#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [topic-name]"
	exit 1
fi

docker exec -it broker \
	kafka-console-producer --bootstrap-server broker:9092 \
             --topic $1
