#!/bin/bash
#
# Lesson 06: Message Keys
#
# Each Kafka message can have an optional key. When a key is provided,
# Kafka hashes the key to determine which partition the message goes to.
# Messages with the same key always go to the same partition, guaranteeing
# ordering for that key.
#
# This is useful for scenarios like: all events for user-123 go to the
# same partition, so they're processed in order.
#
# In this lesson you will:
#   - Send messages with keys
#   - See that same-key messages land in the same partition
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"
TOPICS="$KAFKA_DIR/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP"

echo "============================================"
echo "  Lesson 06: Message Keys"
echo "============================================"
echo ""

# Step 1: Create a topic for this lesson
echo "1. Creating topic 'keyed-topic' with 3 partitions..."
$TOPICS --create --topic keyed-topic --partitions 3 --replication-factor 1 2>/dev/null || true
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Produce messages with keys
echo "2. Sending keyed messages (format: key:value)..."
echo "   Messages with the same key go to the same partition."
echo ""

PRODUCER="${KAFKA_DIR}/bin/kafka-console-producer.sh --bootstrap-server $BOOTSTRAP --topic keyed-topic --property parse.key=true --property key.separator=:"

echo "user-1:login" | $PRODUCER
echo "user-2:login" | $PRODUCER
echo "user-1:view-page" | $PRODUCER
echo "user-3:login" | $PRODUCER
echo "user-2:purchase" | $PRODUCER
echo "user-1:logout" | $PRODUCER
echo "user-2:logout" | $PRODUCER
echo "user-3:view-page" | $PRODUCER

echo "   Sent 8 keyed messages for 3 users."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 3: Consume showing keys and partitions
echo "3. Consuming messages (showing key and partition)..."
echo ""
timeout 5 "${KAFKA_DIR}/bin/kafka-console-consumer.sh" \
    --bootstrap-server "$BOOTSTRAP" \
    --topic keyed-topic --from-beginning \
    --property print.key=true \
    --property print.partition=true 2>/dev/null || true
echo ""
echo "   Notice: all messages for the same user (key) are in the same partition."
echo "   This guarantees per-user ordering."
echo ""

echo "============================================"
echo "  Message keys explored! Next: ./lessons/07-log-retention.sh"
echo "============================================"
