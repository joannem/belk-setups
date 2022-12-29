#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [pf-hostname]"
	exit 1
fi

cd $(dirname ${1})/certs && \

rm -rf ${1}-filebeat-certs/ && \
./../../../1_elasticc-kibana/create_ssl_cert_key.sh ${1}-filebeat && \
cd ${1}-filebeat-certs/ && \
for f in *; do mv $f ${f/${1}-/}; done && \

cd ../../ && \
docker run --rm -d \
	--name=${1}-filebeat \
	--network=monitoring_network \
	--volume="$(pwd)/sample-logs:/data/logs:ro" \
	--volume="$(pwd)/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" \
	--volume="$(pwd)/certs/${1}-filebeat-certs:/usr/share/filebeat/filebeat-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/filebeat/elasticsearch-certs:ro" \
	docker.elastic.co/beats/filebeat:8.2.3 filebeat -e --strict.perms=false
