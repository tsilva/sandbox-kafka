<div align="center">
  <img src="logo.png" alt="sandbox-kafka" width="256"/>

  # sandbox-kafka

  [![Kafka](https://img.shields.io/badge/Kafka-3.9.0-blue?style=flat-square&logo=apachekafka)](https://kafka.apache.org/)
  [![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?style=flat-square&logo=ubuntu)](https://ubuntu.com/)
  [![Java](https://img.shields.io/badge/Java-11-007396?style=flat-square&logo=openjdk)](https://openjdk.org/)
  [![DevContainer](https://img.shields.io/badge/DevContainer-Ready-blue?style=flat-square&logo=visualstudiocode)](https://containers.dev/)

  **A ready-to-use Kafka sandbox for local development and testing with zero configuration**

  [Quick Start](#quick-start) · [Usage](#usage) · [Architecture](#architecture)
</div>

---

## Overview

sandbox-kafka provides a fully configured DevContainer environment with Apache Kafka 3.9.0 and Zookeeper pre-installed. Open the project in VS Code or any DevContainer-compatible editor and start working with Kafka immediately - no manual setup required.

## Features

- **Zero Configuration** - Kafka and Zookeeper start automatically when the container launches
- **Modern Stack** - Kafka 3.9.0 with Scala 2.13 on Ubuntu 22.04
- **DevContainer Native** - Works seamlessly with VS Code Remote Containers
- **Non-Root User** - Runs as `devuser` for security best practices
- **Persistent Logs** - Kafka logs stored in workspace volume for debugging

## Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Launch

1. Clone the repository:
   ```bash
   git clone https://github.com/tsilva/sandbox-kafka.git
   cd sandbox-kafka
   ```

2. Open in VS Code and click "Reopen in Container" when prompted

3. Wait for the container to build - Kafka and Zookeeper will start automatically

4. Verify Kafka is running:
   ```bash
   $KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
   ```

## Usage

All Kafka CLI tools are available in `$KAFKA_HOME/bin/`.

### Create a Topic

```bash
$KAFKA_HOME/bin/kafka-topics.sh --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 1 \
  --topic my-topic
```

### List Topics

```bash
$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```

### Produce Messages

```bash
$KAFKA_HOME/bin/kafka-console-producer.sh \
  --broker-list localhost:9092 \
  --topic my-topic
```

Type messages and press Enter to send. Use `Ctrl+C` to exit.

### Consume Messages

```bash
$KAFKA_HOME/bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic my-topic \
  --from-beginning
```

## Architecture

```
┌─────────────────────────────────────────────────┐
│              DevContainer (Ubuntu 22.04)        │
│                                                 │
│  ┌──────────────┐      ┌──────────────────┐    │
│  │  Zookeeper   │◄────►│   Kafka Broker   │    │
│  │  :2181       │      │   :9092          │    │
│  └──────────────┘      └──────────────────┘    │
│                                                 │
│  /workspace/kafka-logs  (persistent storage)   │
└─────────────────────────────────────────────────┘
```

### Environment Variables

| Variable | Value | Description |
|----------|-------|-------------|
| `KAFKA_HOME` | `/opt/kafka` | Kafka installation directory |
| `KAFKA_VERSION` | `3.9.0` | Kafka version |
| `SCALA_VERSION` | `2.13` | Scala version for Kafka binaries |
| `KAFKA_LOG_DIR` | `/workspace/kafka-logs` | Kafka log storage |

### Ports

| Port | Service |
|------|---------|
| 9092 | Kafka Broker |
| 2181 | Zookeeper |

### Log Files

- Zookeeper: `/workspace/zookeeper.log`
- Kafka: `/workspace/kafka.log`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
