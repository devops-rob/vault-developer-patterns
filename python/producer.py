import requests
import base64
import json
import sys

vaultUrl = "http://localhost:8200/v1/"
vaultToken = "root"
rabbitmqUrl = ""

plaintext {
    "plaintext": "some plaintext"
}

encoded

vaultHeaders = {
    "X-Vault-Token": vaultToken
}

r = requests.post(vaultUrl, data=)

