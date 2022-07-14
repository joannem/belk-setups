#!/bin/bash

rm -rf procsvr-filebeat-certs 
mkdir procsvr-filebeat-certs/

sudo cp \
	/var/lib/docker/volumes/1_elasticc-kibana_certs/_data/ca/ca.crt \
	procsvr-filebeat-certs/. && \
../create_ssl_cert_key.sh procsvr-filebeat && \

docker run -d \
	--name=procsvr-filebeat \
	--network=monitoring_network \
	--volume="$(pwd)/procsvr-filebeat-certs:/usr/share/filebeat/certs:ro" \
	--volume="$(pwd)/procsvr.filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
	--volume="$(pwd)/tutorial-dataset:/data/tutorial-dataset.log:ro" \
	docker.elastic.co/beats/filebeat:8.2.3 filebeat -e --strict.perms=false
