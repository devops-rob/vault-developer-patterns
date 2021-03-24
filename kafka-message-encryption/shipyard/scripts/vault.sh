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
vault write -f transit/keys/kafka type="aes256-gcm96"
