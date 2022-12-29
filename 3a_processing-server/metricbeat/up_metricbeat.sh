#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage $0 [pf-hostname]"
	exit 1
fi

cd $(dirname $0)/certs && \

rm -rf ${1}-metricbeat-certs/ && \
./../../../1_elasticc-kibana/create_ssl_cert_key.sh ${1}-metricbeat && \
cd ${1}-metricbeat-certs/ && \
for f in *; do mv $f ${f/${1}-/}; done && \

cd ../../ && \
docker run --rm -d \
	--name="${1}-metricbeat" \
	--network=monitoring_network \
	--mount type=bind,source=/proc,target=/hostfs/proc,readonly \
	--mount="type=bind,source=/sys/fs/cgroup,target=/hostfs/sys/fs/cgroup,readonly" \
	--mount="type=bind,source=/,target=/hostfs,readonly" \
	--volume="$(pwd)/metricbeat.yml:/usr/share/metricbeat/metricbeat.yml:ro" \
	--volume="$(pwd)/certs/${1}-metricbeat-certs:/usr/share/metricbeat/metricbeat-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/metricbeat/elasticsearch-certs:ro" \
	docker.elastic.co/beats/metricbeat:8.2.3 -e --strict.perms=false
 