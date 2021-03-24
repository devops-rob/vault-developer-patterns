#!/bin/bash
###########################################################################
# Consumer Script
# Consuming messages from Kafka topic and decrypting using Vault's APIs
###########################################################################
# REQUIREMENTS
# jq
# curl
# base64
# kafka cli
##########################################################
# Set the following Env Vars
TOKEN="root"
VAULT_ADDR="http://127.0.0.1:8200/v1"

# Consume message from Kafka topic
consumedmsg=$(kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --max-messages 1 --from-beginning \
    --topic kafka-summit2021 2>/dev/null)

# Decrypt with Vault

data=$(jq -n \
--arg ct "$consumedmsg" \
'{"ciphertext": $ct}')

decryptedmsg=$(curl \
    -H "X-Vault-Token: ${TOKEN}" \
    -X POST \
    -d $data \
    ${VAULT_ADDR}/transit/decrypt/kafka | jq -r .data.plaintext )

# Decode plaintext with base64

echo $decryptedmsg | base64 -d