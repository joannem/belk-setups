#!/bin/bash

sudo sysctl -w vm.max_map_count=262144

docker network create monitoring_network && \
docker compose up -d && \

echo 'To verify run:
sudo curl --cacert /var/lib/docker/volumes/1_elasticc-kibana_certs/_data/ca/ca.crt -u elastic https://localhost:9200'

echo ''
echo 'You should have:
Enter host password for user '"'elastic'"': <enter '"'password'"' here>
{
  "name" : "es01",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "Q21Vi1V8TkuI86DRqN0iHQ",
  "version" : {
    "number" : "8.2.3",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "9905bfb62a3f0b044948376b4f607f70a8a151b4",
    "build_date" : "2022-06-08T22:21:36.455508792Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
'
