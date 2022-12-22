#!/bin/bash

curl -uelastic -X POST http://localhost:5601/api/data_views/data_view \
  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "data_view": {
    "id": "pf3-core-drops",
    "title": "pf3-core-drops",
    "timeFieldName":"@timestamp"
  }
}'
