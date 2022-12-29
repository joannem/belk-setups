#!/bin/bash

curl -uelastic -X POST http://localhost:5601/api/saved_objects/lens/pf3-core-drops-per-host \
  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "attributes": {
    "title": "% Drops per PF3",
    "description": "",
    "visualizationType": "lnsXY",
    "state": {
      "visualization": {
        "title": "XY chart",
        "legend": {
          "isVisible": false,
          "position": "right",
          "showSingleSeries": false
        },
        "valueLabels": "hide",
        "preferredSeriesType": "bar_stacked",
        "layers": [
          {
            "layerId": "idv-avg-perc-drops-layer",
            "accessors": [
              "perc-imiss-ps",
              "perc-rxnombuf-ps",
              "perc-qdrop-ps"
            ],
            "position": "top",
            "seriesType": "bar_stacked",
            "showGridlines": false,
            "layerType": "data",
            "xAccessor": "idv-avg-perc-drops-timestamp",
            "yConfig": [
              {
                "forAccessor": "perc-imiss-ps",
                "color": "#d6bf57"
              },
              {
                "forAccessor": "perc-rxnombuf-ps",
                "color": "#da8b45"
              },
              {
                "forAccessor": "perc-qdrop-ps",
                "color": "#cb772d"
              }
            ]
          },
          {
            "layerId": "tot-avg-perc-drops-layer",
            "layerType": "data",
            "accessors": [
              "tot-perc-drops-ps"
            ],
            "seriesType": "line",
            "xAccessor": "tot-avg-perc-drops-timestamp",
            "yConfig": [
              {
                "forAccessor": "tot-perc-drops-ps",
                "color": "#ff0000"
              }
            ]
          },
          {
            "layerId": "throughput-mbps-layer",
            "layerType": "data",
            "accessors": [
              "avg-rx-mbps"
            ],
            "seriesType": "line",
            "xAccessor": "throughput-mbps-timestamp",
            "yConfig": [
              {
                "forAccessor": "avg-rx-mbps",
                "axisMode": "right",
                "color": "#6092c0"
              }
            ]
          }
        ]
      },
      "query": {
        "query": "host.name: \"b04b83730832\" ",
        "language": "kuery"
      },
      "filters": [],
      "datasourceStates": {
        "indexpattern": {
          "layers": {
            "idv-avg-perc-drops-layer": {
              "columns": {
                "idv-avg-perc-drops-timestamp": {
                  "label": "@timestamp",
                  "dataType": "date",
                  "operationType": "date_histogram",
                  "sourceField": "@timestamp",
                  "isBucketed": true,
                  "scale": "interval",
                  "params": {
                    "interval": "60s",
                    "includeEmptyRows": true,
                    "dropPartials": false,
                    "ignoreTimeRange": false
                  }
                },
                "perc-imiss-ps": {
                  "label": "% imiss ps",
                  "dataType": "number",
                  "operationType": "average",
                  "sourceField": "perc-rx-imiss-ps",
                  "isBucketed": false,
                  "scale": "ratio",
                  "params": {
                    "emptyAsNull": true
                  },
                  "customLabel": true
                },
                "perc-rxnombuf-ps": {
                  "label": "% rxnombuf ps",
                  "dataType": "number",
                  "operationType": "average",
                  "sourceField": "perc-rx-nombuf-ps",
                  "isBucketed": false,
                  "scale": "ratio",
                  "params": {
                    "emptyAsNull": true
                  },
                  "customLabel": true
                },
                "perc-qdrop-ps": {
                  "label": "% qdrop ps",
                  "dataType": "number",
                  "operationType": "average",
                  "sourceField": "perc-rx-qdrop-ps",
                  "isBucketed": false,
                  "scale": "ratio",
                  "params": {
                    "emptyAsNull": true
                  },
                  "customLabel": true
                }
              },
              "columnOrder": [
                "idv-avg-perc-drops-timestamp",
                "perc-imiss-ps",
                "perc-rxnombuf-ps",
                "perc-qdrop-ps"
              ],
              "incompleteColumns": {}
            },
            "tot-avg-perc-drops-layer": {
              "columns": {
                "tot-avg-perc-drops-timestamp": {
                  "label": "@timestamp",
                  "dataType": "date",
                  "operationType": "date_histogram",
                  "sourceField": "@timestamp",
                  "isBucketed": true,
                  "scale": "interval",
                  "params": {
                    "interval": "60s",
                    "includeEmptyRows": true,
                    "dropPartials": false,
                    "ignoreTimeRange": false
                  }
                },
                "tot-perc-drops-ps": {
                  "label": "Tot % drops",
                  "dataType": "number",
                  "operationType": "average",
                  "sourceField": "perc-tot-drops-ps",
                  "isBucketed": false,
                  "scale": "ratio",
                  "params": {
                    "emptyAsNull": true
                  },
                  "customLabel": true
                }
              },
              "columnOrder": [
                "tot-avg-perc-drops-timestamp",
                "tot-perc-drops-ps"
              ],
              "incompleteColumns": {}
            },
            "throughput-mbps-layer": {
              "columns": {
                "throughput-mbps-timestamp": {
                  "label": "@timestamp",
                  "dataType": "date",
                  "operationType": "date_histogram",
                  "sourceField": "@timestamp",
                  "isBucketed": true,
                  "scale": "interval",
                  "params": {
                    "interval": "60s",
                    "includeEmptyRows": true,
                    "dropPartials": false,
                    "ignoreTimeRange": false
                  }
                },
                "avg-rx-mbpsX0": {
                  "label": "Part of average('\''rx-mbps.avg'\'')",
                  "dataType": "number",
                  "operationType": "average",
                  "sourceField": "rx-mbps.avg",
                  "isBucketed": false,
                  "scale": "ratio",
                  "params": {
                    "emptyAsNull": false
                  },
                  "customLabel": true
                },
                "avg-rx-mbps": {
                  "label": "Avg RX Mbps",
                  "dataType": "number",
                  "operationType": "formula",
                  "isBucketed": false,
                  "scale": "ratio",
                  "params": {
                    "formula": "average('\''rx-mbps.avg'\'')",
                    "isFormulaBroken": false
                  },
                  "references": [
                    "avg-rx-mbpsX0"
                  ],
                  "customLabel": true
                }
              },
              "columnOrder": [
                "throughput-mbps-timestamp",
                "avg-rx-mbps",
                "avg-rx-mbpsX0"
              ],
              "incompleteColumns": {}
            }
          }
        }
      }
    }
  },
  "references": [
    {
      "type": "index-pattern",
      "id": "pf3-core-drops",
      "name": "indexpattern-datasource-current-indexpattern"
    },
    {
      "type": "index-pattern",
      "id": "pf3-core-drops",
      "name": "indexpattern-datasource-layer-idv-avg-perc-drops-layer"
    },
    {
      "type": "index-pattern",
      "id": "pf3-core-drops",
      "name": "indexpattern-datasource-layer-tot-avg-perc-drops-layer"
    },
    {
      "type": "index-pattern",
      "id": "pf3-core-drops",
      "name": "indexpattern-datasource-layer-throughput-mbps-layer"
    }
  ],
  "migrationVersion": {
    "lens": "8.2.0"
  },
  "coreMigrationVersion": "8.2.3"
}'