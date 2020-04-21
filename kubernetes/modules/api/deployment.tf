resource "kubernetes_namespace" "api" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "mongodb-auth-secrets" {
  depends_on = [
    kubernetes_namespace.api
  ]

  metadata {
    name = "mongodb-auth-secrets"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-api"
    }
  }

  data = {
    MONGODB_USR = var.mongodb_usr
    MONGODB_PWD = var.mongodb_pwd
  }

  type = "Opaque"
}

resource "kubernetes_deployment" "api-deployment" {
  depends_on = [
    kubernetes_secret.mongodb-auth-secrets
  ]

  metadata {
    name      = "api-deployment"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-api"
    }
  }

  spec {
    replicas = var.api_replicas
    selector {
      match_labels = {
        app = "devops7220-final-api"
      }
    }
    revision_history_limit = 3
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
    }

    template {
      metadata {
        labels = {
          app = "devops7220-final-api"
        }
        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/path" = "/metrics"
          "prometheus.io/port"   = "5000"
        }
      }

      spec {
        container {
          image = var.api_image
          name  = "api-container"
          resources {
            limits {
              cpu    = "100m"
              memory = "100Mi"
            }
            requests {
              cpu    = "50m"
              memory = "50Mi"
            }
          }

          env_from {
            secret_ref {
              name = "mongodb-auth-secrets"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 5000
            }
            initial_delay_seconds = 10
            period_seconds        = 100
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api-service" {
  depends_on = [
    kubernetes_deployment.api-deployment
  ]

  metadata {
    name = "api-service"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-api"
    }
  }
  spec {
    selector = {
    #   app = "${kubernetes_deployment.api.spec[0].selector[0].match_labels.app}"
        app = "devops7220-final-api"
    }
    port {
      port        = 5000
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}