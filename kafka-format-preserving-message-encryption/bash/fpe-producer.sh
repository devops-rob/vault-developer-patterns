#!/bin/bash
#############################################################################
# Producer Script
# Performing Format Preserving Encryption of App data and publishing to Kafka
#############################################################################
# REQUIREMENTS
# jq
# curl
# base64
# Kafka CLI
##########################################################

# Setup Kafka Topic
kafka-topics --bootstrap-server localhost:9092 \
    --create --topic kafka-payments \
    --if-not-exists --partitions 3 \
    --replication-factor 1

# Perform FPE on CCN using Vault's Transform Engine

encryptedmccn=$(curl \
    -H "X-Vault-Token: root" \
    -X POST \
    -d '{"value": "0101-1212-2323-3434", "transformation": "ccn-fpe"}' \
    http://127.0.0.1:8200/v1/transform/encode/payments | jq -r .data.encoded_value)

echo $encryptedmccn

# Publish CCN to queue

echo $encryptedmccn | \
    kafka-console-producer \
    --broker-list localhost:9092 \
    --topic kafka-payments 2>/dev/null

