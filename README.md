<div align="center">
  <img src="logo.png" alt="sandbox-kafka" width="512"/>

  **📨 DevContainer-based Kafka sandbox for local development and testing**

</div>

## Overview

A Kafka sandbox environment designed for local development and testing. Uses DevContainer to provide a containerized environment with Kafka 3.9.0 and Zookeeper pre-installed.

## Features

- **Pre-configured setup** - Kafka 3.9.0 and Zookeeper ready to use
- **DevContainer** - Ubuntu 22.04 with Java 11 and Miniconda
- **Auto-start** - Services start automatically on container launch
- **Non-root user** - Runs as `devuser` for security

## Quick Start

1. Open in VS Code with DevContainer extension
2. Container builds and starts automatically
3. Kafka is ready on port 9092, Zookeeper on 2181

## Common Commands

```bash
# List topics
$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list

# Create topic
$KAFKA_HOME/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 \
  --replication-factor 1 --partitions 1 --topic my-topic

# Produce messages
$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic my-topic

# Consume messages
$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
  --topic my-topic --from-beginning
```

## Environment

| Variable | Value |
|----------|-------|
| `KAFKA_HOME` | `/opt/kafka` |
| `KAFKA_VERSION` | `3.9.0` |
| `SCALA_VERSION` | `2.13` |
| `KAFKA_LOG_DIR` | `/workspace/kafka-logs` |

## Requirements

- Docker
- VS Code with DevContainer extension

## License

MIT
