#!/bin/bash
###########################################################################
# Producer Script
# Encrypting application data using Vault's API and publishing to Kafka
###########################################################################
# REQUIREMENTS
# jq
# curl
# base64
# Kafka CLI
##########################################################

# Setup Kafka Topic
kafka-topics --bootstrap-server localhost:9092 \
    --create --topic kafka-summit2021 \
    --if-not-exists --partitions 3 \
    --replication-factor 1

# Encode plaintext with base64
msg="DevOps Rob Speaking at Kafka Summit EU 2021"
echo $msg
payload=$(echo ${msg} | base64)
echo $payload

json_string=$(jq -n \
--arg pt "$payload" \
'{"plaintext": $pt}')

echo $json_string
# Encrypt payload using Kafka cryptographic key in Vault

encryptedmsg=$(curl \
    -H "X-Vault-Token: root" \
    -X POST \
    -d "$json_string" \
    http://127.0.0.1:8200/v1/transit/encrypt/kafka | jq -r .data.ciphertext)

# Publish message to queue
echo $encryptedmsg

echo $encryptedmsg | \
    kafka-console-producer \
    --broker-list localhost:9092 \
    --topic kafka-summit2021 2>/dev/null

