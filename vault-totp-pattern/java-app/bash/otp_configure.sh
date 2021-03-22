#!/bin/bash

# Set the following Env Vars
TOKEN="root"
VAULT_ADDR="http://127.0.0.1:8200/v1"

# Create a key for OTP

otpkey=$(curl ${VAULT_ADDR}/totp/keys/devopsrob \
    -H "x-vault-token: ${TOKEN}" \
    -d '{"generate": true, "issuer": "devopsrob", "account_name": "barnes.rob"}' | jq)

# Extract the barcode from response and decode with base64
barcode=$(echo $otpkey | jq -r .data.barcode | base64 -d)

# Create a PNG file with the barcode for a scanner
echo $barcode > ${PWD}/barcode.png

# Scan barcode with Google Authenticator or 1Password
