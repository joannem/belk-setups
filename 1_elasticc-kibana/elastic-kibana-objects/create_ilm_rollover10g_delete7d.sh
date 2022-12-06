#!/bin/bash

curl -k -uelastic -X PUT https://localhost:9200/_ilm/policy/ilm-policy-rollover10g-delete7d -H 'Content-Type: application/json' -d '
{
  "policy": {
    "phases": {
      "hot": {
        "actions": {
          "rollover": {
            "max_size": "10GB"
          }
        }
      },
      "delete": {
        "min_age": "7d",
        "actions": {
          "delete": {}
        }
      }
    }
  }
}'