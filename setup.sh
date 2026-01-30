#!/bin/bash
#
# setup.sh - Download and configure Kafka 4.1.1 in KRaft mode
#
# This script:
#   1. Checks that Java 17+ is installed
#   2. Downloads Kafka 4.1.1 if not already present
#   3. Generates a KRaft cluster ID and formats storage
#   4. Makes all scripts executable
#

set -e

KAFKA_VERSION="4.1.1"
KAFKA_DIR="./kafka"
KAFKA_TARBALL="kafka_2.13-${KAFKA_VERSION}.tgz"
KAFKA_URL="https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/${KAFKA_TARBALL}"

echo "=== Kafka Tutorial Setup ==="
echo ""

# Step 1: Check Java 17+
echo "Checking Java installation..."
if ! command -v java &> /dev/null; then
    echo "ERROR: Java is not installed."
    echo ""
    echo "Install Java 17 or later:"
    echo "  macOS:   brew install openjdk@17"
    echo "  Ubuntu:  sudo apt install openjdk-17-jdk"
    echo "  Fedora:  sudo dnf install java-17-openjdk"
    echo ""
    echo "Then re-run this script."
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -1 | sed 's/.*"\([0-9]*\)\..*/\1/')
if [ "$JAVA_VERSION" -lt 17 ] 2>/dev/null; then
    echo "ERROR: Java 17+ is required, but found Java ${JAVA_VERSION}."
    echo ""
    echo "Install Java 17 or later and re-run this script."
    exit 1
fi
echo "Found Java ${JAVA_VERSION}. OK."
echo ""

# Step 2: Download Kafka
if [ -d "$KAFKA_DIR" ]; then
    echo "Kafka directory already exists. Skipping download."
else
    echo "Downloading Kafka ${KAFKA_VERSION}..."
    curl -fSL "$KAFKA_URL" -o "/tmp/${KAFKA_TARBALL}"
    echo "Extracting..."
    mkdir -p "$KAFKA_DIR"
    tar -xzf "/tmp/${KAFKA_TARBALL}" -C "$KAFKA_DIR" --strip-components=1
    rm -f "/tmp/${KAFKA_TARBALL}"
    echo "Kafka extracted to ${KAFKA_DIR}/"
fi
echo ""

# Step 3: Format KRaft storage
KRAFT_CONFIG="${KAFKA_DIR}/config/kraft/server.properties"
if [ ! -d "${KAFKA_DIR}/kraft-combined-logs" ] && [ ! -d "/tmp/kraft-combined-logs" ]; then
    echo "Generating KRaft cluster ID and formatting storage..."
    CLUSTER_ID=$("${KAFKA_DIR}/bin/kafka-storage.sh" random-uuid)
    "${KAFKA_DIR}/bin/kafka-storage.sh" format -t "$CLUSTER_ID" -c "$KRAFT_CONFIG"
    echo "KRaft storage formatted with cluster ID: ${CLUSTER_ID}"
else
    echo "KRaft storage already formatted. Skipping."
fi
echo ""

# Step 4: Make all scripts executable
chmod +x setup.sh start-kafka.sh stop-kafka.sh lessons/*.sh 2>/dev/null || true

echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Start Kafka:    ./start-kafka.sh"
echo "  2. In a new terminal, run lessons:  ./lessons/00-verify-setup.sh"
echo ""
