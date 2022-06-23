#!/bin/bash

docker run -d \
	--name=logstash \
	--user=root \
	--network=elasticc-kibana_default \
	--volume="$(pwd)/ca.crt:/usr/share/logstash/certs/ca.crt:z" \
	--volume="$(pwd)/logstash.docker.yml:/usr/share/logstash/config/logstash.yml:ro" \
	--volume="$(pwd)/pipeline/:/usr/share/logstash/pipeline/:ro" \
	docker.elastic.co/logstash/logstash:8.2.3
