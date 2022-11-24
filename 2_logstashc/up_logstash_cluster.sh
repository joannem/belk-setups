#!/bin/bash

cd $(dirname $0)/certs

rm -rf logstash-certs/ && \
./../../1_elasticc-kibana/create_ssl_cert_key.sh logstash && \
./create_and_configure_elastic_api_key.sh && \

cd ../
docker run --rm -d \
	--name=logstash \
	--user=root \
	--network=monitoring_network \
	--volume="$(pwd)/logstash.yml:/usr/share/logstash/config/logstash.yml:ro" \
	--volume="$(pwd)/pipeline:/usr/share/logstash/pipeline:ro" \
	--volume="$(pwd)/certs/logstash-certs:/usr/share/logstash/logstash-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/logstash/elasticsearch-certs:ro" \
	docker.elastic.co/logstash/logstash:8.2.3
