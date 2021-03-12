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

TOKEN="root"
VAULT_ADDR="http://127.0.0.1:8200/v1"
RABBITMQ_ADDR="http://localhost:15672/api"

# Encode plaintext with base64
plaintext="some plaintext data"
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

curl -u guest:guest -H "content-type:application/json" \
    -X POST -d $message \
    ${RABBITMQ_ADDR}/exchanges/%2F/owasp.devslop/publish


