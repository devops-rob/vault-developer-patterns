container "vault" {
    network {
        name = "network.local"
    }

    image {
        name = "hashicorp/vault-enterprise:1.7.0_ent"
    }

    env_var = {
      VAULT_DEV_ROOT_TOKEN_ID = var.vault_root_token
    }

    port {
      local = "8200"
      remote = "8200"
      host = "8200"
    }

  volume {
    source = "./scripts"
    destination = "/scripts"
  }
}