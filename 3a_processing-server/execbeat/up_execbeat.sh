#!/bin/bash

cd $(dirname $0)/certs && \


./../../../1_elasticc-kibana/create_ssl_cert_key.sh pf1-execbeat && \

cd ../
docker run --rm -d \
	--name=pf1-execbeat \
	--network=monitoring_network \
	--volume="$(pwd)/execbeat.yml:/usr/share/execbeat/execbeat.yml:ro" \
	--volume="$(pwd)/certs/pf1-execbeat-certs:/usr/share/execbeat/pf1-execbeat-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/execbeat/elasticsearch-certs:ro" \
	ubi8-execbeat:devel
