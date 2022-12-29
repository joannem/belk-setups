#!/bin/bash

curl -k -uelastic -X PUT https://localhost:9200/_transform/pf3-core-drops -H 'Content-Type: application/json' -d'
{
  "source": {
    "index": [
      "pf3-core-logs-*"
    ]
  },
  "pivot": {
    "group_by": {
      "pf3-timestamp": { "terms": { "field": "pf3-timestamp" } },
      "host.name": { "terms": { "field": "host.name.keyword" } },
      "@timestamp": { "date_histogram": { "field": "@timestamp", "calendar_interval": "1m" } }
    },
    "aggregations": {
      "rx-pkts-ps.avg": { "avg": { "field": "rx-pkts-ps" } },
      "rx-imiss-ps.avg": { "avg": { "field": "rx-imiss-ps" } },
      "rx-nombuf-ps.avg": { "avg": { "field": "rx-nombuf-ps" } },
      "rx-qdrop-ps.avg": { "avg": { "field": "rx-qdrop-ps" } },
      "tx-omiss-ps.avg": { "avg": { "field": "tx-omiss-ps" } },
      "tx-oqdrop-ps.avg": { "avg": { "field": "tx-oqdrop-ps" } },
      "fdrop-ps.avg": { "avg": { "field": "fdrop-ps" } },
      "rdrop-ps.avg": { "avg": { "field": "rdrop-ps" } },
      "ldrop-ps.avg": { "avg": { "field": "ldrop-ps" } },
      "rx-mbps.avg": { "avg": { "field": "rx-mbps" } }
    }
  },
  "description": "Avg of all drops across all interfaces within a log segment per pf3",
  "dest": {
    "index": "pf3-core-drops"
  },
  "sync": {
    "time": {
      "field": "@timestamp"
    }
  },
  "retention_policy": {
    "time": {
      "field": "@timestamp",
      "max_age": "7d"
    }
  }
}'