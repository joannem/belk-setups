#!/bin/bash

curl -k -uelastic -X PUT https://localhost:9200/_index_template/pf3-core-logs -H 'Content-Type: application/json' -d '
{
  "index_patterns": [ "pf3-core-logs-*" ],
  "data_stream": { },
  "priority": 500,
  "template": {
  "settings": {
    "index.lifecycle.name": "ilm-policy-rollover10g-delete7d",
    "index.routing.allocation.include._tier_preference": "data_hot"
  },
  "mappings":{
    "properties": {
      "@timestamp": { "type":"date" },
      "pf3-timestamp": { "type": "unsigned_long" },
      "log-level": { "type": "text" },
      "dpdk-rx-intf": { "type": "text" },
      "rx-imiss": { "type": "unsigned_long" },
      "rx-nombuf": { "type": "unsigned_long" },
      "rx-intf": { "type": "text" },
      "rx-qdrop": { "type": "unsigned_long" },
      "dpdk-tx-intf": { "type": "text" },
      "tx-omiss": { "type": "unsigned_long" },
      "tx-intf": { "type": "text" },
      "tx-oqdrop": { "type": "unsigned_long" },
      "rx-mbps": { "type": "float" },
      "fdrop": { "type": "unsigned_long" },
      "rdrop": { "type": "unsigned_long" },
      "ldrop": { "type": "unsigned_long" }
    }
  }
  }
}'