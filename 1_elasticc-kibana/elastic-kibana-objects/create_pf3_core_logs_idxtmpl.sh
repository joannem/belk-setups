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
        "pf3-timestamp": { "type": "keyword" },
        "log-level": { "type": "keyword" },
        "dpdk-rx-intf": { "type": "keyword" },
        "rx-pkts": {"type": "unsigned_long"},
        "rx-pkts-ps": {"type": "double"},
        "rx-imiss": { "type": "unsigned_long" },
        "rx-imiss-ps": { "type": "double" },
        "rx-nombuf": { "type": "unsigned_long" },
        "rx-nombuf-ps": { "type": "double" },
        "rx-intf": { "type": "keyword" },
        "rx-qdrop": { "type": "unsigned_long" },
        "rx-qdrop-ps": { "type": "double" },
        "dpdk-tx-intf": { "type": "keyword" },
        "tx-pkts": {"type": "unsigned_long"},
        "tx-pkts-ps": {"type": "double"},
        "tx-omiss": { "type": "unsigned_long" },
        "tx-omiss-ps": { "type": "double" },
        "tx-intf": { "type": "keyword" },
        "tx-oqdrop": { "type": "unsigned_long" },
        "tx-oqdrop-ps": { "type": "double" },
        "rx-mbps": { "type": "double" },
        "fdrop": { "type": "unsigned_long" },
        "fdrop-ps": { "type": "double" },
        "rdrop": { "type": "unsigned_long" },
        "rdrop-ps": { "type": "double" },
        "ldrop": { "type": "unsigned_long" },
        "ldrop-ps": { "type": "double" }
      }
    }
  }
}'