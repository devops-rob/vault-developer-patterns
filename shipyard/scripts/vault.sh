# Wait for Vault to ready
#
#  vault status 
#
#  if [ "$?" == 0 ]; then
#    echo "Vault Running"
#    break
#  fi
#
#  sleep 1
#done
#
## Setup TOTP
#

while true; do
  vault status 

  if [ "$?" == 0 ]; then
    echo "Vault Running"
    break
  fi

  sleep 1
done

# sleep 10

vault secrets enable transit
vault write -f transit/keys/devslop type="aes256-gcm96"

vault secrets enable totp