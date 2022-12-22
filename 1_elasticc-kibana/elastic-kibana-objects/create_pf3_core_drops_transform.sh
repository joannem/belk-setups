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
      "rx-pkts-ps.sum": { "sum": { "field": "rx-pkts-ps" } },
      "rx-imiss-ps.sum": { "sum": { "field": "rx-imiss-ps" } },
      "rx-nombuf-ps.sum": { "sum": { "field": "rx-nombuf" } },
      "rx-qdrop-ps.sum": { "sum": { "field": "rx-qdrop" } },
      "tx-omiss-ps.sum": { "sum": { "field": "tx-omiss" } },
      "tx-oqdrop-ps.sum": { "sum": { "field": "tx-oqdrop" } },
      "fdrop-ps.sum": { "sum": { "field": "fdrop" } },
      "rdrop-ps.sum": { "sum": { "field": "rdrop" } },
      "ldrop-ps.sum": { "sum": { "field": "ldrop" } },
      "rx-mbps.avg": { "avg": { "field": "rx-mbps" } }
    }
  },
  "description": "Sum of all drops across all interfaces within a log segment per pf3",
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