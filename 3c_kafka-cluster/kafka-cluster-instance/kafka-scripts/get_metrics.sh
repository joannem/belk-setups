#!/bin/bash

PREV_PID=$(docker exec broker ps -ef | \
	grep " java" | awk '{print $2}' | \
	grep -v "^1$")
echo ${PREV_PID}

if [ -n "$PREV_PID" ]; then
      docker exec broker kill ${PREV_PID}
fi

## For ref: kafka-run-class kafka.tools.JmxTool --object-name kafka.server:type=BrokerTopicMetrics,name=MessagesInPerSec

docker exec broker /bin/bash -c \
	"export JMX_PORT=1099 && kafka-run-class kafka.tools.JmxTool --object-name kafka.server:type=BrokerTopicMetrics,name=MessagesInPerSec --object-name kafka.server:type=BrokerTopicMetrics,name=BytesInPerSec --object-name kafka.server:type=BrokerTopicMetrics,name=BytesOutPerSec"
