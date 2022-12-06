#!/bin/bash

curl -uelastic -X POST -H "kbn-xsrf: reporting" http://localhost:5601/api/data_views/data_view -H 'Content-Type: application/json' -d '
{
  "data_view": {
    "id": "pf3-core-logs",
    "title": "pf3-core-logs-*",
    "timeFieldName": "@timestamp"
    "fields": {
      "@timestamp": {
        "type": "date",
        "esTypes": [ "date" ],
      },
      "dpdk-rx-intf": {
        "name": "dpdk-rx-intf",
        "type": "string",
        "esTypes": [ "text" ],
      },
      "dpdk-tx-intf": {
        "name": "dpdk-tx-intf",
        "type": "string",
        "esTypes": [ "text" ],
      },
      "fdrop": {
        "name": "fdrop",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "ldrop": {
        "name": "ldrop",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "log-level": {
        "name": "log-level",
        "type": "string",
        "esTypes": [ "text" ],
      },
      "pf3-timestamp": {
        "name": "pf3-timestamp",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "rdrop": {
        "name": "rdrop",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "rx-imiss": {
        "name": "rx-imiss",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "rx-intf": {
        "name": "rx-intf",
        "type": "string",
        "esTypes": [ "text" ],
      },
      "rx-mbps": {
        "name": "rx-mbps",
        "type": "number",
        "esTypes": [ "float" ],
      },
      "rx-nombuf": {
        "name": "rx-nombuf",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "rx-qdrop": {
        "name": "rx-qdrop",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "tx-intf": {
        "name": "tx-intf",
        "type": "string",
        "esTypes": [ "text" ],
      },
      "tx-omiss": {
        "name": "tx-omiss",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      },
      "tx-oqdrop": {
        "name": "tx-oqdrop",
        "type": "number",
        "esTypes": [ "unsigned_long" ],
      }
    }
  }
}'
