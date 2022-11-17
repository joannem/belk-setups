#!/bin/bash

cd $(dirname $0)

docker cp 1_elasticc-kibana-es01-1:/usr/share/elasticsearch/config/certs/ca/ca.crt . && \
API_KEY=`curl --cacert ca.crt -u elastic \
-X POST "https://localhost:9200/_security/api_key?pretty" \
-H 'Content-Type: application/json' -d'
{
  "name": "logstash-api-key"
}
' | jq '.id + ":" + .api_key'` && \

sed -i "s/api_key => .*/api_key => ${API_KEY}/g" ../pipeline/*.conf && \

rm ca.crt
