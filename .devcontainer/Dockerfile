FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    git \
    ca-certificates \
    nano \
    software-properties-common \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p $CONDA_DIR \
    && rm -rf /tmp/miniconda.sh \
    && $CONDA_DIR/bin/conda clean -afy

# Install Kafka
ENV KAFKA_VERSION=3.9.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka

RUN curl -fsSL https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -o /tmp/kafka.tgz \
    && mkdir -p ${KAFKA_HOME} \
    && tar -xzf /tmp/kafka.tgz -C ${KAFKA_HOME} --strip-components=1 \
    && rm -rf /tmp/kafka.tgz

ENV PATH=$KAFKA_HOME/bin:$PATH

# Create a non-root user
RUN groupadd --gid 1000 devuser \
    && useradd --uid 1000 --gid devuser --shell /bin/bash --create-home devuser \
    && mkdir -p /workspace/data \
    && chown -R devuser:devuser /workspace

# Change ownership of Kafka directory to devuser
RUN mkdir -p /opt/kafka/logs && chown -R devuser:devuser /opt/kafka

# Copy Entrypoint script
COPY --chown=devuser:devuser entrypoint.sh /workspace/entrypoint.sh

# Ensure Entrypoint script is executable
RUN chmod +x /workspace/entrypoint.sh

# Switch to the non-root user
USER devuser
WORKDIR /workspace

# Ensure conda is initialized for the user
RUN /opt/conda/bin/conda init bash

# Expose necessary ports
EXPOSE 9092 2181

# Set shell and entrypoint
ENV SHELL=/bin/bash
ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD ["sleep", "infinity"]
