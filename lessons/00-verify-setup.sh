#!/bin/bash
#
# Lesson 00: Verify Setup
#
# Before starting the tutorials, let's make sure everything is working.
# This script checks that Java and Kafka are properly installed and running.
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"

echo "============================================"
echo "  Lesson 00: Verify Setup"
echo "============================================"
echo ""

# Check Java
echo "1. Checking Java..."
java -version 2>&1 | head -1
echo "   OK"
echo ""

# Check Kafka directory
echo "2. Checking Kafka installation..."
if [ ! -d "$KAFKA_DIR" ]; then
    echo "   ERROR: Kafka not found at ${KAFKA_DIR}. Run ./setup.sh first."
    exit 1
fi
echo "   Kafka found at ${KAFKA_DIR}"
echo ""

# Check Kafka is running
echo "3. Checking Kafka connectivity..."
if "${KAFKA_DIR}/bin/kafka-topics.sh" --bootstrap-server "$BOOTSTRAP" --list &>/dev/null; then
    echo "   Kafka is running and accepting connections on ${BOOTSTRAP}"
else
    echo "   ERROR: Cannot connect to Kafka on ${BOOTSTRAP}."
    echo "   Make sure you ran ./start-kafka.sh in another terminal."
    exit 1
fi
echo ""

echo "============================================"
echo "  Setup verified! You're ready to learn Kafka."
echo "  Next: ./lessons/01-create-topics.sh"
echo "============================================"
