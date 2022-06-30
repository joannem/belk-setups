#!/bin/bash

docker run -d \
	--name=procsvr-filebeat \
	--network=elasticc-kibana_default \
	--volume="$(pwd)/procsvr.filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
	--volume="$(pwd)/tutorial-dataset:/data/tutorial-dataset.log:ro" \
	--volume="elasticc-kibana_certs:/etc/pki:ro" \
	docker.elastic.co/beats/filebeat:8.2.3 filebeat -e --strict.perms=false

# --user=root \
# --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
# --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \