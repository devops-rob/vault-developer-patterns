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
    VAULT_ADDR="http://vault.container.shipyard.run:8200"
  }
  
  volume {
    source = "./scripts"
    destination = "/scripts"
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