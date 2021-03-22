output "VAULT_ADDR" {
  value = "http://localhost:8200"
}

output "VAULT_TOKEN" {
  value = var.vault_root_token
}

output "KAFKA_ADDR" {
  value = "http://localhost:9092"
}

output "ZOOKEEPER_ADDR" {
  value = "http://localhost:2181"
}