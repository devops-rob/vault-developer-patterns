# Java application with Vault integration

## POST /auth

Authenticates with Vault and returns a JWT

```
curl localhost:8080/auth -H "Content-Type: application/json" -d '{"username": "nic", "password": "pass"}'
```