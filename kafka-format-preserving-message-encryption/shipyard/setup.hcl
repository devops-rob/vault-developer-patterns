exec_remote "setup_vault" {
  target = "container.vault"

  image {
    name = "curlimages/curl:latest"
  }
  
  network {
    name = "network.local"
  }

  cmd = "sh"
  args = ["/scripts/vault.sh"]

  env_var = {
    VAULT_ADDR="http://localhost:8200"
    VAULT_TOKEN="root"
  }
}

exec_remote "setup_kafka" {

 target = "container.kafka"
 
 network {
   name = "network.local"
 }

 cmd = "sh"
 args = ["/scripts/kafka.sh"]
}
