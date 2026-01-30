#!/bin/bash
#
# stop-kafka.sh - Stop a running Kafka server
#

KAFKA_DIR="./kafka"

if [ ! -d "$KAFKA_DIR" ]; then
    echo "ERROR: Kafka not found. Run ./setup.sh first."
    exit 1
fi

echo "Stopping Kafka..."
"${KAFKA_DIR}/bin/kafka-server-stop.sh"
echo "Kafka stopped."
