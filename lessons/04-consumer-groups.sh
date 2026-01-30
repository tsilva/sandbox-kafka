#!/bin/bash
#
# Lesson 04: Consumer Groups
#
# A consumer group is a set of consumers that cooperate to consume a topic.
# Each partition is assigned to exactly one consumer in the group, enabling
# parallel processing. Kafka tracks each group's offsets so consumers can
# resume where they left off.
#
# In this lesson you will:
#   - Consume with a named consumer group
#   - See how offsets are tracked per group
#   - Check consumer group lag
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"
CONSUMER="$KAFKA_DIR/bin/kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP"
GROUPS="$KAFKA_DIR/bin/kafka-consumer-groups.sh --bootstrap-server $BOOTSTRAP"

echo "============================================"
echo "  Lesson 04: Consumer Groups"
echo "============================================"
echo ""

# Step 1: Produce some messages
echo "1. Producing 10 messages to 'my-first-topic'..."
for i in $(seq 1 10); do
    echo "group-test-message-$i" | "${KAFKA_DIR}/bin/kafka-console-producer.sh" \
        --bootstrap-server "$BOOTSTRAP" \
        --topic my-first-topic
done
echo "   Sent 10 messages."
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Consume with a group
echo "2. Consuming with consumer group 'my-group'..."
echo "   (Auto-exits after 5 seconds of silence)"
echo ""
timeout 5 $CONSUMER --topic my-first-topic --from-beginning \
    --group my-group 2>/dev/null || true
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 3: List consumer groups
echo "3. Listing consumer groups:"
$GROUPS --list
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 4: Describe the group (show offsets and lag)
echo "4. Describing consumer group 'my-group':"
$GROUPS --describe --group my-group
echo ""
echo "   CURRENT-OFFSET: where the group has read up to"
echo "   LOG-END-OFFSET:  the latest message in the partition"
echo "   LAG:             how many unread messages remain"
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 5: Produce more and show lag
echo "5. Producing 5 more messages to create lag..."
for i in $(seq 1 5); do
    echo "lag-test-$i" | "${KAFKA_DIR}/bin/kafka-console-producer.sh" \
        --bootstrap-server "$BOOTSTRAP" \
        --topic my-first-topic
done
echo ""
echo "   Consumer group lag after new messages:"
$GROUPS --describe --group my-group
echo ""
echo "   Notice the LAG column now shows unread messages."
echo ""

echo "============================================"
echo "  Consumer groups explored! Next: ./lessons/05-partitions.sh"
echo "============================================"
