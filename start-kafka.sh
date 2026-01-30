#!/bin/bash
#
# start-kafka.sh - Start Kafka in KRaft mode (foreground)
#
# Run this in a dedicated terminal. Kafka logs will stream to stdout.
# Use Ctrl+C or ./stop-kafka.sh from another terminal to stop.
#

set -e

KAFKA_DIR="./kafka"

if [ ! -d "$KAFKA_DIR" ]; then
    echo "ERROR: Kafka not found. Run ./setup.sh first."
    exit 1
fi

echo "Starting Kafka in KRaft mode..."
echo "Press Ctrl+C to stop."
echo ""

exec "${KAFKA_DIR}/bin/kafka-server-start.sh" "${KAFKA_DIR}/config/kraft/server.properties"
