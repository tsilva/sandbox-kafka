#!/bin/bash
#
# Lesson 08: Cleanup
#
# This script deletes all topics created during the tutorials and provides
# instructions for stopping Kafka.
#

set -e

KAFKA_DIR="./kafka"
BOOTSTRAP="localhost:9092"
TOPICS="$KAFKA_DIR/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP"

echo "============================================"
echo "  Lesson 08: Cleanup"
echo "============================================"
echo ""

# Step 1: List existing topics
echo "1. Current topics:"
$TOPICS --list
echo ""

read -p "Delete all tutorial topics? (y/N) " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo ""
    echo "   Deleting topics..."
    for topic in my-first-topic multi-partition-topic keyed-topic short-retention-topic compacted-topic; do
        $TOPICS --delete --topic "$topic" 2>/dev/null && echo "   Deleted: $topic" || true
    done
    echo ""
    echo "   Remaining topics:"
    $TOPICS --list
else
    echo "   Skipped topic deletion."
fi

echo ""
echo "============================================"
echo "  Cleanup complete!"
echo ""
echo "  To stop Kafka:"
echo "    ./stop-kafka.sh"
echo "    (or Ctrl+C in the terminal running start-kafka.sh)"
echo ""
echo "  To remove Kafka entirely:"
echo "    rm -rf ./kafka"
echo ""
echo "  Congratulations on completing the Kafka tutorial!"
echo "============================================"
