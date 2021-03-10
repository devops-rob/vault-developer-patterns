container "zookeeper" {
    network {
        name = "network.local"
    }

    image {
        name = "bitnami/zookeeper:latest"
    }
    
    port {
      host = "2181"
      remote = "2181"
      local = "2181"
    }

    env_var = {
      ALLOW_ANONYMOUS_LOGIN = "yes"
    }
}

container "kafka" {
    network {
        name = "network.local"
    }

    image {
        name = "bitnami/kafka:latest"
    }

    port {
      host = "9092"
      remote = "9092"
      local = "9092"
    }

    env_var = {
      KAFKA_BROKER_ID = "1"
      KAFKA_LISTENERS = "PLAINTEXT://:9092"
      KAFKA_ADVERTISED_LISTENERS = "PLAINTEXT://127.0.0.1:9092"
      KAFKA_ZOOKEEPER_CONNECT = "zookeeper.container.shipyard.run:2181"
      ALLOW_PLAINTEXT_LISTENER = "yes"
    }
}