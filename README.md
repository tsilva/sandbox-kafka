# sandbox-kafka
A sandbox for kafka

You can confirm that Kafka is running by checking its logs, testing the broker with a topic, and ensuring the process is active. Below are different ways to verify:

### **4️⃣ List Kafka Topics**
If Kafka is running correctly, it should allow listing topics.

Run:
```bash
$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```
✅ **Expected Output:** If Kafka is running, it may return an empty list (`No topics exist`) or a list of available topics.

---

### **5️⃣ Create and Test a Kafka Topic**
Try creating a topic to ensure Kafka is functioning:

```bash
$KAFKA_HOME/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test-topic
```
Then, list topics again:
```bash
$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
```
✅ **Expected Output:** `test-topic` should appear.

---

### **6️⃣ Test Producing & Consuming Messages**
✅ **Start a producer**:
```bash
$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test-topic
```
(Type a message and press enter.)

✅ **Start a consumer**:
```bash
$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --from-beginning
```
🔹 The message you typed in the producer should appear in the consumer.
