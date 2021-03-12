# Wait for Vault to ready
#while true; do
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
#vault secrets enable totp

echo "hello"