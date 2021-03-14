#!/bin/bash
###########################################################################
# Producer Script
# Encrypting application data using Vault's API and publishing to RabbitMQ
###########################################################################
# REQUIREMENTS
# jq
# curl
# base64
##########################################################
# Set the following Env Vars
TOKEN="root"
VAULT_ADDR="http://127.0.0.1:8200/v1"
RABBITMQ_ADDR="http://localhost:15672/api"

# Setup RabbitMQ config
# ./shipyard/scripts/rabbitmq-setup.sh

# Create login details for RabbitMQ

rabbitcredsp=$(curl \
    -H "X-Vault-Token: ${TOKEN}" \
    ${VAULT_ADDR}/rabbitmq/creds/devslop | jq)

rabbituserp=$(echo $rabbitcredsp | jq -r .data.username)
rabbitpassp=$(echo $rabbitcredsp | jq -r .data.password)
rabbittokenp="${rabbituserp}:${rabbitpassp}"

# Encode plaintext with base64
plaintext="DevSlop Meets DevOps Rob"
payload=$(echo ${plaintext} | base64)

JSON_STRING=$( jq -n \
    --arg pt "$payload" \
    '{"plaintext": $pt}' )

# Encrypt payload using key in Vault

ciphertext=$(curl \
    -H "X-Vault-Token: ${TOKEN}" \
    -X POST \
    -d $JSON_STRING \
    ${VAULT_ADDR}/transit/encrypt/devslop | jq -r .data.ciphertext )


# Publish to queue

routingkey="devopsrob"

message=$( jq -n \
    --arg msg "$ciphertext" \
    --arg rk "$routingkey" \
    '{"properties":{}, "routing_key": $rk, "payload":$msg, "payload_encoding":"string"}'
)

curl -u${rabbittokenp} \
    -H "content-type:application/json" \
    -X POST -d $message \
    ${RABBITMQ_ADDR}/exchanges/%2F/owasp.devslop/publish


