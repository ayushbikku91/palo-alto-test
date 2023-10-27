provider "google" {
  credentials = file("<YOUR_SERVICE_ACCOUNT_KEY_FILE>")
  project     = "<YOUR_PROJECT_ID>"
  region      = "us-central1"
}

resource "google_container_cluster" "my_cluster" {
  name               = "my-cluster"
  location           = "us-central1"
  initial_node_count = 1

  node_config {
    machine_type = "n1-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }
}

resource "google_container_node_pool" "my_node_pool" {
  name       = "my-node-pool"
  location   = google_container_cluster.my_cluster.location
  cluster    = google_container_cluster.my_cluster.name
  node_count = 1

  node_config {
    machine_type = "n1-standard-2"
  }
}

resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-deployment"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "nginx-service"
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
