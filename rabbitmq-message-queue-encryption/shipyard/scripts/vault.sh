while true; do
  vault status 

  if [ "$?" == 0 ]; then
    echo "Vault Running"
    break
  fi

  sleep 1
done

# Enable Transit Secrets engine
vault secrets enable transit
vault write -f transit/keys/devslop type="aes256-gcm96"

#Enable TOTP Secrets engine
vault secrets enable totp

# Enable RabbitMQ Secrets engine
vault secrets enable rabbitmq

sleep 10 # There is some kind of race condition that prevents connection working.

vault write rabbitmq/config/connection \
    connection_uri="http://rabbitmq.container.shipyard.run:15672" \
    username="guest" \
    password="guest" \
    verify_connection=true

vault write rabbitmq/roles/devslop \
    vhosts='{"/":{"write": ".*", "read": ".*"}}' \
    tags="administrator"