#!/bin/bash
#
# Lesson 05: Partitions and Ordering
#
# A topic is divided into partitions. Each partition is an ordered, immutable
# log. Messages are ordered within a partition but NOT across partitions.
# Partitions enable parallelism — multiple consumers in a group can each
# read from different partitions simultaneously.
#
# In this lesson you will:
#   - Send messages to a multi-partition topic
#   - Observe how messages are distributed across partitions
#   - See that ordering is per-partition, not global
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"

echo "============================================"
echo "  Lesson 05: Partitions and Ordering"
echo "============================================"
echo ""

# Step 1: Send numbered messages to the 3-partition topic
echo "1. Sending 12 messages to 'multi-partition-topic' (3 partitions)..."
for i in $(seq 1 12); do
    echo "message-$i" | "${KAFKA_DIR}/bin/kafka-console-producer.sh" \
        --bootstrap-server "$BOOTSTRAP" \
        --topic multi-partition-topic
done
echo "   Sent 12 messages."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Consume showing partition info
echo "2. Consuming all messages (showing partition and offset)..."
echo ""
timeout 5 "${KAFKA_DIR}/bin/kafka-console-consumer.sh" \
    --bootstrap-server "$BOOTSTRAP" \
    --topic multi-partition-topic --from-beginning \
    --property print.partition=true \
    --property print.offset=true 2>/dev/null || true
echo ""
echo "   Notice: messages are ordered within each partition (offsets go 0,1,2,...)"
echo "   but the overall order across partitions may differ from send order."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 3: Consume from a single partition
echo "3. Consuming only from partition 0..."
echo ""
timeout 5 "${KAFKA_DIR}/bin/kafka-console-consumer.sh" \
    --bootstrap-server "$BOOTSTRAP" \
    --topic multi-partition-topic --from-beginning \
    --partition 0 \
    --property print.offset=true 2>/dev/null || true
echo ""
echo "   Messages within a single partition are always in order."
echo ""

echo "============================================"
echo "  Partitions explored! Next: ./lessons/06-message-keys.sh"
echo "============================================"
