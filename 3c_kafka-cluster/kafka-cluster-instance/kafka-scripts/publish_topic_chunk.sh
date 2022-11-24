#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage $0 [topic-name] [msgs-file]"
	exit 1
fi

docker exec -i broker \
	kafka-console-producer --bootstrap-server broker:9092 \
	--topic $1 < $2
