#!/bin/bash

TOKEN="root"
VAULT_ADDR="http://127.0.0.1:8200/v1"

# Scan barcode with Google Authenticator or 1Password

# Verify code with Vault
echo "Enter One-time passcode"
read code
code_json=$(jq -n \
    --arg cd "$code" \
    '{"code": $cd}')

curl ${VAULT_ADDR}/totp/code/devopsrob -H \
    "x-vault-token: ${TOKEN}" -d $code_json | jq