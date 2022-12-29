#!/bin/bash

curl -uelastic -X POST http://localhost:5601/api/saved_objects/visualization/pf3-core-drops-per-cluster \
  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "attributes": {
    "visState": "{\"title\":\"% Drops in PF3 Cluster\",\"type\":\"timelion\",\"aggs\":[],\"params\":{\"expression\":\".es(index=pf3-core-drops,\\n    timefield='\''@timestamp'\'',\\n    metric='\''avg:rx-mbps.avg'\'')\\n  .yaxis(2)\\n  .label('\''RX Mbps'\''),\\n\\n.es(index=pf3-core-drops,\\n    timefield='\''@timestamp'\'',\\n    split=host.name:100,\\n    metric='\''max:perc-tot-drops-ps'\'')\\n  .if(gte, 10, 1, 0)\\n  .sum()\\n  .bars(stack=true)\\n  .label('\''drops: 10-100 %'\''),\\n\\n.es(index=pf3-core-drops,\\n    timefield='\''@timestamp'\'',\\n    split=host.name:100,\\n    metric='\''max:perc-tot-drops-ps'\'')\\n  .if(gte, 1, \\n  .es(index=pf3-core-drops,\\n    timefield='\''@timestamp'\'',\\n    split=host.name:100,\\n    metric='\''max:perc-tot-drops-ps'\'')\\n    .if(lt, 10, 1, 0), \\n  0)\\n  .sum()\\n  .bars(stack=true)\\n  .label('\''drops: 1-10 %'\'')\",\"interval\":\"auto\"}}",
    "title": "% Drops in PF3 Cluster",
    "uiStateJSON": "{}",
    "description": "",
    "version": 1,
    "kibanaSavedObjectMeta": {
      "searchSourceJSON": "{\"query\":{\"query\":\"\",\"language\":\"kuery\"},\"filter\":[]}"
    }
  },
  "references": [],
  "migrationVersion": {
    "visualization": "8.1.0"
  },
  "coreMigrationVersion": "8.2.3"
}'