# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a hands-on Kafka tutorial project. Users learn Kafka fundamentals by running progressive shell script lessons that use the Kafka CLI tools directly. No Docker required — just Java 17+ and a terminal.

## Architecture

- **Kafka 4.1.1** running in **KRaft mode** (no ZooKeeper)
- `setup.sh` downloads Kafka, generates a cluster ID, and formats KRaft storage
- `start-kafka.sh` runs Kafka in the foreground using `config/kraft/server.properties`
- `stop-kafka.sh` stops the Kafka server
- `lessons/00-08` are progressive tutorial scripts using `./kafka/bin/` CLI tools

## File Structure

```
setup.sh                      # Download & configure Kafka 4.1.1 (KRaft)
start-kafka.sh                # Start Kafka in foreground
stop-kafka.sh                 # Stop Kafka
lessons/
  00-verify-setup.sh          # Verify Java + Kafka running
  01-create-topics.sh         # Create, list, describe topics
  02-produce-messages.sh      # Console producer
  03-consume-messages.sh      # Console consumer, offsets
  04-consumer-groups.sh       # Consumer groups, lag
  05-partitions.sh            # Multi-partition ordering
  06-message-keys.sh          # Key-based routing
  07-log-retention.sh         # Retention & compaction
  08-cleanup.sh               # Delete topics, clean up
```

## Key Paths

- `./kafka/` — Kafka installation (downloaded by setup.sh, gitignored)
- `./kafka/bin/` — Kafka CLI tools (kafka-topics.sh, kafka-console-producer.sh, etc.)
- `./kafka/config/kraft/server.properties` — KRaft server configuration

## Common Commands

```bash
# Kafka CLI tools are at ./kafka/bin/
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
./kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1 --topic <name>
./kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic <name>
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic <name> --from-beginning
```

## Important Instructions

- **README.md**: Must be kept up to date with any significant project changes
- All lesson scripts follow the same pattern: header comments, numbered steps, `read -p` pauses between steps
- Kafka runs on port 9092 (KRaft mode, no ZooKeeper port needed)
