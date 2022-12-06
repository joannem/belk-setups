#!/bin/bash

cd $(dirname $0)/certs && \

rm -rf pf1-filebeat-certs/ && \
./../../../1_elasticc-kibana/create_ssl_cert_key.sh pf1-filebeat && \

cd ../
docker run --rm -d \
	--name=pf1-filebeat \
	--network=monitoring_network \
	--volume="$(pwd)/sample-logs:/data/logs:ro" \
	--volume="$(pwd)/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" \
	--volume="$(pwd)/certs/pf1-filebeat-certs:/usr/share/filebeat/pf1-filebeat-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/filebeat/elasticsearch-certs:ro" \
	docker.elastic.co/beats/filebeat:8.2.3 filebeat -e --strict.perms=false
