#!/bin/bash
############################################################################
# Consumer Script
# Consuming encrypted message from RabbitMQ and decrypting it with Vault API
############################################################################
# REQUIREMENTS
# jq
# curl
# base64
##########################################################

TOKEN="root"
VAULT_ADDR="http://127.0.0.1:8200/v1"
RABBITMQ_ADDR="http://localhost:15672/api"

# Create login details for RabbitMQ

rabbitcredsc=$(curl \
    -H "X-Vault-Token: ${TOKEN}" \
    ${VAULT_ADDR}/rabbitmq/creds/devslop | jq)

rabbituserc=$(echo $rabbitcredsc | jq -r .data.username)
rabbitpassc=$(echo $rabbitcredsc | jq -r .data.password)
rabbittokenc="${rabbituserc}:${rabbitpassc}"

# Consume message from queue

consumer=$(curl -u $rabbittokenc -H "content-type:application/json" \
    -X POST \
    -d'{"count":5,"requeue":true,"encoding":"auto","truncate":50000,"ackmode": "ack_requeue_false"}' \
    ${RABBITMQ_ADDR}/queues/%2f/devopsrob/get | jq -r -c '.[].payload')

# Decrypt with Vault

data=$(jq -n \
--arg ct "$consumer" \
'{"ciphertext": $ct}')

plaintext=$(curl \
    -H "X-Vault-Token: ${TOKEN}" \
    -X POST \
    -d $data \
    ${VAULT_ADDR}/transit/decrypt/devslop | jq -r .data.plaintext )

# Decode plaintext with base64

echo $plaintext | base64 -d

