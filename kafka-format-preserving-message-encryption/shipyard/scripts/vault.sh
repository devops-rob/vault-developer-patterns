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

# Enable Transform Secrets engine
vault secrets enable transform
vault write transform/role/payments transformations=ccn-fpe

vault write transform/transformation/ccn-fpe \
  type=fpe \
  template=builtin/creditcardnumber \
  tweak_source=internal \
  allowed_roles=payments

