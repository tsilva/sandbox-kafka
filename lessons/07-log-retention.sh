#!/bin/bash
#
# Lesson 07: Log Retention and Compaction
#
# Kafka doesn't delete messages immediately after consumption. Instead, it
# retains messages based on configurable policies:
#
#   - Time-based retention: delete messages older than X (default: 7 days)
#   - Size-based retention: delete oldest messages when log exceeds X bytes
#   - Log compaction: keep only the latest value for each key
#
# In this lesson you will:
#   - View default retention settings
#   - Create a compacted topic
#   - See how compaction works with keys
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"
TOPICS="$KAFKA_DIR/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP"
CONFIGS="$KAFKA_DIR/bin/kafka-configs.sh --bootstrap-server $BOOTSTRAP"

echo "============================================"
echo "  Lesson 07: Log Retention & Compaction"
echo "============================================"
echo ""

# Step 1: Check default retention
echo "1. Checking retention config for 'my-first-topic'..."
$CONFIGS --describe --entity-type topics --entity-name my-first-topic
echo ""
echo "   Default retention is 7 days (retention.ms=604800000)."
echo "   If no overrides are shown, the broker defaults apply."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Create a topic with short retention
echo "2. Creating 'short-retention-topic' with 10-second retention..."
$TOPICS --create --topic short-retention-topic \
    --partitions 1 --replication-factor 1 \
    --config retention.ms=10000 2>/dev/null || true
echo ""

echo "   Sending messages..."
for i in $(seq 1 5); do
    echo "ephemeral-$i" | "${KAFKA_DIR}/bin/kafka-console-producer.sh" \
        --bootstrap-server "$BOOTSTRAP" --topic short-retention-topic
done
echo "   Sent 5 messages. They will be eligible for deletion after 10 seconds."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 3: Create a compacted topic
echo "3. Creating 'compacted-topic' with log compaction..."
$TOPICS --create --topic compacted-topic \
    --partitions 1 --replication-factor 1 \
    --config cleanup.policy=compact 2>/dev/null || true
echo ""

PRODUCER="${KAFKA_DIR}/bin/kafka-console-producer.sh --bootstrap-server $BOOTSTRAP --topic compacted-topic --property parse.key=true --property key.separator=:"

echo "   Sending multiple values for the same keys..."
echo "color:red" | $PRODUCER
echo "size:small" | $PRODUCER
echo "color:blue" | $PRODUCER
echo "size:large" | $PRODUCER
echo "color:green" | $PRODUCER
echo "   Sent: color=red, size=small, color=blue, size=large, color=green"
echo ""
echo "   With compaction, eventually only the LATEST value per key is kept:"
echo "   color=green, size=large"
echo "   (Compaction runs in the background; it may take time to take effect.)"
echo ""

echo "============================================"
echo "  Retention explored! Next: ./lessons/08-cleanup.sh"
echo "============================================"
