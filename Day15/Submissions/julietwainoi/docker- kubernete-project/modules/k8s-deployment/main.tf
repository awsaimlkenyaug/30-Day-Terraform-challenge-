resource "kubernetes_deployment" "app" {
  metadata {
    name = "my-app"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          name  = "my-app"
          image = "${aws_ecr_repository.app_repo.repository_url}:latest"
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}
# (Optional) Add LoadBalancer Service
resource "kubernetes_service" "app" {
  metadata {
    name = "my-app-service"
  }

  spec {
    selector = {
      app = "my-app"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 3000
    }
  }
}
