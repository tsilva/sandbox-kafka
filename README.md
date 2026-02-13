<div align="center">
  <img src="logo.png" alt="sandbox-kafka" width="512"/>

  **📨 Hands-on Kafka tutorial with progressive shell script lessons 🎓**

</div>

## What is Kafka?

Apache Kafka is a distributed event streaming platform used for building real-time data pipelines and streaming applications. Think of it as a durable, high-throughput message bus: producers write messages to topics, and consumers read them.

This project is a hands-on tutorial that teaches Kafka fundamentals through progressive shell script lessons. No frameworks, no application code — just you, a terminal, and the Kafka CLI tools.

## Prerequisites

- **Java 17+** — [Download](https://adoptium.net/)
- **A terminal** (macOS, Linux, or WSL on Windows)
- **curl** (pre-installed on most systems)

Check your Java version:
```bash
java -version
```

## Quick Start

```bash
# 1. Download and configure Kafka 4.1.1
./setup.sh

# 2. Start Kafka (keep this terminal open)
./start-kafka.sh

# 3. In a new terminal, verify everything works
./lessons/00-verify-setup.sh

# 4. Start learning!
./lessons/01-create-topics.sh
```

## Lessons

| # | Script | What You'll Learn |
|---|--------|-------------------|
| 00 | `00-verify-setup.sh` | Verify Java and Kafka are running |
| 01 | `01-create-topics.sh` | Create, list, and describe topics |
| 02 | `02-produce-messages.sh` | Send messages with the console producer |
| 03 | `03-consume-messages.sh` | Read messages, understand offsets |
| 04 | `04-consumer-groups.sh` | Shared consumption, offset tracking, lag |
| 05 | `05-partitions.sh` | Multi-partition ordering guarantees |
| 06 | `06-message-keys.sh` | Key-based routing to partitions |
| 07 | `07-log-retention.sh` | Time-based retention and log compaction |
| 08 | `08-cleanup.sh` | Delete topics and shut down |

Run them in order — each lesson builds on concepts from previous ones.

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Broker** | A Kafka server that stores and serves messages |
| **Topic** | A named stream of messages (like a database table) |
| **Partition** | A topic is split into partitions for parallelism; ordering is guaranteed within a partition |
| **Producer** | An application that writes messages to a topic |
| **Consumer** | An application that reads messages from a topic |
| **Consumer Group** | A set of consumers that share the work of reading a topic |
| **Offset** | A sequential ID assigned to each message in a partition |
| **KRaft** | Kafka's built-in consensus protocol, replacing the need for ZooKeeper |

## Stopping and Cleaning Up

```bash
# Stop Kafka
./stop-kafka.sh

# Remove Kafka installation
rm -rf ./kafka
```

## License

MIT
