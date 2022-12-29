#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [pf-hostname]"
	exit 1
fi

cd $(dirname $0)/certs && \

rm -rf ${1}-execbeat-certs/ && \
./../../../1_elasticc-kibana/create_ssl_cert_key.sh ${1}-execbeat && \
cd ${1}-execbeat-certs/ && \
for f in *; do mv $f ${f/${1}-/}; done && \

cd ../../ && \
docker run --rm -d \
	--name=${1}-execbeat \
	--network=monitoring_network \
	--volume="$(pwd)/execbeat.yml:/usr/share/execbeat/execbeat.yml:ro" \
	--volume="$(pwd)/certs/${1}-execbeat-certs:/usr/share/execbeat/execbeat-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/execbeat/elasticsearch-certs:ro" \
	ubi8-execbeat:devel
