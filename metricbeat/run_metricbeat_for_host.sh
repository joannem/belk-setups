#!/bin/bash

docker run -d \
	--name="metricbeat-host" \
	--volume="$(pwd)/metricbeat.docker.yml:/usr/share/metricbeat/metricbeat.yml:ro" \
	--volume="elasticc-kibana_certs:/etc/pki:ro" \
	--mount type=bind,source=/proc,target=/hostfs/proc,readonly \
	--mount="type=bind,source=/sys/fs/cgroup,target=/hostfs/sys/fs/cgroup,readonly" \
	--mount="type=bind,source=/,target=/hostfs,readonly" \
	--net=host \
	docker.elastic.co/beats/metricbeat:8.2.3 -e -system.hostfs=/hostfs
 