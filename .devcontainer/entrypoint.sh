#!/bin/bash

set -e

KAFKA_HOME=/opt/kafka
KAFKA_CONFIG=$KAFKA_HOME/config

# Ensure log directory is writable
mkdir -p /workspace/kafka-logs
export KAFKA_LOG_DIR=/workspace/kafka-logs

# Update Kafka config to use the new log directory
sed -i "s|log.dirs=.*|log.dirs=$KAFKA_LOG_DIR|g" $KAFKA_CONFIG/server.properties

# Start Zookeeper
echo "Starting Zookeeper..."
$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_CONFIG/zookeeper.properties > /workspace/zookeeper.log 2>&1 &

# Wait for Zookeeper to start
sleep 5

# Start Kafka
echo "Starting Kafka..."
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_CONFIG/server.properties > /workspace/kafka.log 2>&1 &

sleep 5

echo "Kafka and Zookeeper started successfully!"

# Keep the container running
exec "$@"
