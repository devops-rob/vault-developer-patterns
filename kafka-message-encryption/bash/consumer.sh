#!/bin/bash

# Consume message from Kafka topic
consumedmsg=$(kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --max-messages 1 --from-beginning \
    --topic kafka-summit2021 2>/dev/null)

echo $consumedmsg

# Decrypt with Vault

data=$(jq -n \
--arg ct "$consumedmsg" \
'{"ciphertext": $ct}')

echo $data

decryptedmsg=$(curl \
    -H "X-Vault-Token: root" \
    -X POST \
    -d "$data" \
    http://127.0.0.1:8200/v1/transit/decrypt/kafka | jq -r .data.plaintext )

# Decode plaintext with base64

echo $decryptedmsg | base64 -d