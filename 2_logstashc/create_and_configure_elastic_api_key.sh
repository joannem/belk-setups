#!/bin/bash


API_KEY=`sudo curl --cacert /var/lib/docker/volumes/1_elasticc-kibana_certs/_data/ca/ca.crt -u elastic \
-X POST "https://localhost:9200/_security/api_key?pretty" \
-H 'Content-Type: application/json' -d'
{
  "name": "logstash-api-key"
}
' | jq '.id + ":" + .api_key'`

sed -i "s/api_key => .*/api_key => ${API_KEY}/g" pipeline/*.conf 
