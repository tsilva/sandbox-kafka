#!/bin/bash
#
# Lesson 02: Produce Messages
#
# A producer sends messages to a Kafka topic. Messages are appended to the
# topic's log and assigned an offset (a sequential ID).
#
# In this lesson you will:
#   - Send messages to a topic using the console producer
#   - See how messages are stored
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"

echo "============================================"
echo "  Lesson 02: Produce Messages"
echo "============================================"
echo ""

# Step 1: Send some messages programmatically
echo "1. Sending 5 messages to 'my-first-topic'..."
for i in $(seq 1 5); do
    echo "Hello Kafka message $i" | "${KAFKA_DIR}/bin/kafka-console-producer.sh" \
        --bootstrap-server "$BOOTSTRAP" \
        --topic my-first-topic
done
echo "   Sent 5 messages."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Interactive producer
echo "2. Now try the interactive producer."
echo "   Type messages and press Enter to send each one."
echo "   Press Ctrl+C when done."
echo ""
"${KAFKA_DIR}/bin/kafka-console-producer.sh" \
    --bootstrap-server "$BOOTSTRAP" \
    --topic my-first-topic

echo ""
echo "============================================"
echo "  Messages produced! Next: ./lessons/03-consume-messages.sh"
echo "============================================"
