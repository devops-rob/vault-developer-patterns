#!/bin/bash

#Consume message from Kafka topic
consumedmsg=$(kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --max-messages 1 --from-beginning \
    --topic kafka-payments 2>/dev/null)

echo $consumedmsg

data=$(jq -n \
--arg ct "$consumedmsg" \
'{"value": $ct, "transformation": "ccn-fpe"}')

echo $data

# Decode the consumed message
decodedmsg=$(curl \
    -H "X-Vault-Token: root" \
    -X POST \
    -d "$data" \
    http://127.0.0.1:8200/v1/transform/decode/payments | jq -r .data.decoded_value)

echo $decodedmsg