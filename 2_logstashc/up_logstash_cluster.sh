#!/bin/bash

sudo cp /var/lib/docker/volumes/1_elasticc-kibana_certs/_data/ca/ca.crt . && \

docker run -d \
	--name=logstash \
	--user=root \
	--network=monitoring_network \
	--volume="$(pwd)/ca.crt:/usr/share/logstash/certs/ca.crt:ro" \
	--volume="$(pwd)/logstash.docker.yml:/usr/share/logstash/config/logstash.yml:ro" \
	--volume="$(pwd)/pipeline/:/usr/share/logstash/pipeline/:ro" \
	docker.elastic.co/logstash/logstash:8.2.3
