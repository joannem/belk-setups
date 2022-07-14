#!/bin/bash

cd $(dirname $0)

./create_and_configure_elastic_api_key.sh && \

docker run -d \
	--name=logstash \
	--user=root \
	--network=monitoring_network \
	--volume="$(pwd)/logstash.docker.yml:/usr/share/logstash/config/logstash.yml:ro" \
	--volume="$(pwd)/pipeline/:/usr/share/logstash/pipeline/:ro" \
	--volume="1_elasticc-kibana_certs:/usr/share/logstash/certs:ro" \
	docker.elastic.co/logstash/logstash:8.2.3

# --volume="$(pwd)/../../3a_processing-server/filebeat/procsvr-filebeat-certs:/usr/share/logstash/procsvr-filebeat-certs/:ro" \
