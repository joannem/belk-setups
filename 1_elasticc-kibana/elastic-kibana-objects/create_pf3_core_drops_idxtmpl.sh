#!/bin/bash

curl -k -uelastic -X PUT https://localhost:9200/_index_template/pf3-core-drops -H 'Content-Type: application/json' -d '
{
  "index_patterns": [ "pf3-core-drops" ],
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
        "host.name": { "type": "keyword" },
        "rx-pkts-ps.avg": {"type": "double"},
        "rx-imiss-ps.avg": { "type": "double" },
        "rx-nombuf-ps.avg": { "type": "double" },
        "rx-qdrop-ps.avg": { "type": "double" },
        "tx-omiss-ps.avg": { "type": "double" },
        "tx-oqdrop-ps.avg": { "type": "double" },
        "fdrop-ps.avg": { "type": "double" },
        "rdrop-ps.avg": { "type": "double" },
        "ldrop-ps.avg": { "type": "double" },
        "rx-mbps.avg": { "type": "double" }
      },
      "runtime": {
        "perc-rx-imiss-ps": {
          "type": "double",
          "script": {
            "source": "emit(doc['\''rx-imiss-ps.avg'\''].value / doc['\''rx-pkts-ps.avg'\''].value * 100)"
          }
        },
        "perc-rx-nombuf-ps": {
          "type": "double",
          "script": {
            "source": "emit(doc['\''rx-nombuf-ps.avg'\''].value / doc['\''rx-pkts-ps.avg'\''].value * 100)"
          }
        },
        "perc-rx-qdrop-ps": {
          "type": "double",
          "script": {
            "source": "emit(doc['\''rx-qdrop-ps.avg'\''].value / doc['\''rx-pkts-ps.avg'\''].value * 100)"
          }
        },
        "perc-tot-drops-ps": {
          "type": "double",
          "script": {
            "source": "emit((doc['\''rx-imiss-ps.avg'\''].value + doc['\''rx-nombuf-ps.avg'\''].value + doc['\''rx-qdrop-ps.avg'\''].value) / doc['\''rx-pkts-ps.avg'\''].value * 100)"
          }
        }
      }
    }
  }
}'