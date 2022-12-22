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
      "pf3-timestamp": { "type": "text" },
      "log-level": { "type": "text" },
      "dpdk-rx-intf": { "type": "text" },
      "rx-imiss": { "type": "unsigned_long" },
      "rx-imiss-ps": { "type": "float" },
      "rx-nombuf": { "type": "unsigned_long" },
      "rx-nombuf-ps": { "type": "float" },
      "rx-intf": { "type": "text" },
      "rx-qdrop": { "type": "unsigned_long" },
      "rx-qdrop-ps": { "type": "float" },
      "dpdk-tx-intf": { "type": "text" },
      "tx-omiss": { "type": "unsigned_long" },
      "tx-omiss-ps": { "type": "float" },
      "tx-intf": { "type": "text" },
      "tx-oqdrop": { "type": "unsigned_long" },
      "tx-oqdrop-ps": { "type": "float" },
      "rx-mbps": { "type": "float" },
      "fdrop": { "type": "unsigned_long" },
      "fdrop-ps": { "type": "float" },
      "rdrop": { "type": "unsigned_long" },
      "rdrop-ps": { "type": "float" },
      "ldrop": { "type": "unsigned_long" },
      "ldrop-ps": { "type": "float" }
    }
  }
  }
}'