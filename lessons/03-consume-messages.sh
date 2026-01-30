#!/bin/bash
#
# Lesson 03: Consume Messages
#
# A consumer reads messages from a Kafka topic. Consumers track their position
# using offsets. You can start reading from the beginning of a topic or only
# see new messages arriving in real time.
#
# In this lesson you will:
#   - Consume all messages from the beginning
#   - Understand offset behavior
#   - See real-time message consumption
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"
CONSUMER="$KAFKA_DIR/bin/kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP"

echo "============================================"
echo "  Lesson 03: Consume Messages"
echo "============================================"
echo ""

# Step 1: Consume from the beginning
echo "1. Reading ALL messages from 'my-first-topic' (from beginning)..."
echo "   (Will auto-exit after 5 seconds of no new messages)"
echo ""
timeout 5 $CONSUMER --topic my-first-topic --from-beginning 2>/dev/null || true
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Consume with offsets shown
echo "2. Reading messages with partition, offset, and timestamp info..."
echo ""
timeout 5 $CONSUMER --topic my-first-topic --from-beginning \
    --property print.partition=true \
    --property print.offset=true \
    --property print.timestamp=true 2>/dev/null || true
echo ""
echo "   Each message has a partition number, offset, and timestamp."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 3: Real-time consumption
echo "3. Now let's consume in real time."
echo "   This consumer will wait for NEW messages."
echo "   Open another terminal and run:"
echo "     echo 'live message' | ./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic my-first-topic"
echo ""
echo "   Press Ctrl+C to stop the consumer."
echo ""
$CONSUMER --topic my-first-topic

echo ""
echo "============================================"
echo "  Consuming done! Next: ./lessons/04-consumer-groups.sh"
echo "============================================"
