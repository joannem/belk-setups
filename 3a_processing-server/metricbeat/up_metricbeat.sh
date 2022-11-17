#!/bin/bash

cd $(dirname $0)/certs && \


./../../../1_elasticc-kibana/create_ssl_cert_key.sh pf1-metricbeat && \

cd ../
docker run -d \
	--name="pf1-metricbeat" \
	--network=monitoring_network \
	--mount type=bind,source=/proc,target=/hostfs/proc,readonly \
	--mount="type=bind,source=/sys/fs/cgroup,target=/hostfs/sys/fs/cgroup,readonly" \
	--mount="type=bind,source=/,target=/hostfs,readonly" \
	--volume="$(pwd)/metricbeat.yml:/usr/share/metricbeat/metricbeat.yml:ro" \
	--volume="$(pwd)/certs/pf1-metricbeat-certs:/usr/share/metricbeat/pf1-metricbeat-certs:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/metricbeat/elasticsearch-certs:ro" \
	docker.elastic.co/beats/metricbeat:8.2.3 -e --strict.perms=false
 