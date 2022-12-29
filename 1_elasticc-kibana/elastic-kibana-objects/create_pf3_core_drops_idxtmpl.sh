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
        "rx-pkts-ps.sum": {"type": "double"},
        "rx-imiss-ps.sum": { "type": "double" },
        "rx-nombuf-ps.sum": { "type": "double" },
        "rx-qdrop-ps.sum": { "type": "double" },
        "tx-omiss-ps.sum": { "type": "double" },
        "tx-oqdrop-ps.sum": { "type": "double" },
        "fdrop-ps.sum": { "type": "double" },
        "rdrop-ps.sum": { "type": "double" },
        "ldrop-ps.sum": { "type": "double" },
        "rx-mbps.avg": { "type": "double" }
      },
      "runtime": {
        "perc-rx-imiss-ps": {
          "type": "double",
          "script": {
            "source": "if (doc['\''rx-imiss-ps.sum'\''].size() != 0 && doc['\''rx-pkts-ps.sum'\''].size() != 0) emit(doc['\''rx-imiss-ps.sum'\''].value / doc['\''rx-pkts-ps.sum'\''].value * 100)"
          }
        },
        "perc-rx-nombuf-ps": {
          "type": "double",
          "script": {
            "source": "if (doc['\''rx-nombuf-ps.sum'\''].size() != 0 && doc['\''rx-pkts-ps.sum'\''].size() != 0) emit(doc['\''rx-nombuf-ps.sum'\''].value / doc['\''rx-pkts-ps.sum'\''].value * 100)"
          }
        },
        "perc-rx-qdrop-ps": {
          "type": "double",
          "script": {
            "source": "if (doc['\''rx-qdrop-ps.sum'\''].size() != 0 && doc['\''rx-pkts-ps.sum'\''].size() != 0) emit(doc['\''rx-qdrop-ps.sum'\''].value / doc['\''rx-pkts-ps.sum'\''].value * 100)"
          }
        },
        "perc-tot-drops-ps": {
          "type": "double",
          "script": {
            "source": "if (doc['\''rx-imiss-ps.sum'\''].size() != 0 && doc['\''rx-nombuf-ps.sum'\''].size() != 0 && doc['\''rx-qdrop-ps.sum'\''].size() != 0 && doc['\''rx-pkts-ps.sum'\''].size() != 0) emit((doc['\''rx-imiss-ps.sum'\''].value + doc['\''rx-nombuf-ps.sum'\''].value + doc['\''rx-qdrop-ps.sum'\''].value) / doc['\''rx-pkts-ps.sum'\''].value * 100)"
          }
        }
      }
    }
  }
}'