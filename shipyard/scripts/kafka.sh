# Wait for Kafka to be ready
while true; do

  kafka-broker-api-versions.sh --bootstrap-server localhost:9092 --version
  echo $?
  if test "$?" = "0"; then
    echo "Kafka Running"
    break
  fi

  sleep 1
done

# Create a kafka topic tester
kafka-topics.sh --bootstrap-server localhost:9092 --create --topic tester --partitions 3 --replication-factor 1