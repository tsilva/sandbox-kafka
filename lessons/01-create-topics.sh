#!/bin/bash
#
# Lesson 01: Create Topics
#
# A topic is a named stream of messages in Kafka. Producers write to topics,
# and consumers read from them. Before you can send any messages, you need
# to create a topic.
#
# In this lesson you will:
#   - Create a topic
#   - List all topics
#   - Describe a topic's configuration
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"
TOPICS="$KAFKA_DIR/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP"

echo "============================================"
echo "  Lesson 01: Create Topics"
echo "============================================"
echo ""

# Step 1: Create a topic
echo "1. Creating topic 'my-first-topic' with 1 partition..."
$TOPICS --create --topic my-first-topic --partitions 1 --replication-factor 1
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 2: Create a topic with multiple partitions
echo "2. Creating topic 'multi-partition-topic' with 3 partitions..."
$TOPICS --create --topic multi-partition-topic --partitions 3 --replication-factor 1
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 3: List all topics
echo "3. Listing all topics:"
$TOPICS --list
echo ""

read -p "Press Enter to continue..."
echo ""

# Step 4: Describe a topic
echo "4. Describing 'multi-partition-topic':"
$TOPICS --describe --topic multi-partition-topic
echo ""
echo "   Notice: PartitionCount is 3, each partition has a leader broker."
echo ""

echo "============================================"
echo "  Topics created! Next: ./lessons/02-produce-messages.sh"
echo "============================================"
