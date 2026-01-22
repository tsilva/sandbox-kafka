# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Kafka sandbox environment designed for local development and testing. The project uses a DevContainer setup to provide a containerized environment with Kafka 3.9.0 and Zookeeper pre-installed.

## Environment Setup

The development environment is managed through DevContainer configuration:
- **Docker**: Ubuntu 22.04 base with Java 11, Miniconda, and Kafka 3.9.0
- **Automatic startup**: Zookeeper and Kafka are automatically started via entrypoint.sh
- **Ports**: Kafka runs on port 9092, Zookeeper on port 2181
- **User**: Runs as non-root user `devuser`

## Key Environment Variables

- `KAFKA_HOME=/opt/kafka` - Kafka installation directory
- `KAFKA_VERSION=3.9.0` - Kafka version
- `SCALA_VERSION=2.13` - Scala version for Kafka binaries
- `KAFKA_LOG_DIR=/workspace/kafka-logs` - Kafka log storage

## Common Kafka Commands

All Kafka CLI tools are located in `$KAFKA_HOME/bin/`. Common commands:

### List Topics
```bash
$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```

### Create Topic
```bash
$KAFKA_HOME/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic <topic-name>
```

### Produce Messages
```bash
$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic <topic-name>
```

### Consume Messages
```bash
$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic <topic-name> --from-beginning
```

## Architecture Notes

- **Entrypoint script** (.devcontainer/entrypoint.sh): Handles automatic startup of Zookeeper and Kafka when the container starts
- **Log files**: Zookeeper logs at `/workspace/zookeeper.log`, Kafka logs at `/workspace/kafka.log`
- **Data persistence**: Kafka logs are stored in `/workspace/kafka-logs` (mapped to host volume via DevContainer)
- **Configuration**: Kafka configuration is modified at startup to use the writable workspace log directory

## Important Instructions

- **README.md**: Must be kept up to date with any significant project changes
