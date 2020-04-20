resource "kubernetes_namespace" "ui" {
  metadata {
    name = var.namespace
  }
}

data "kubernetes_service" "api-service-info" {
  metadata {
    name = "api-service-info"
    namespace = var.api_namespace
  }
}

resource "kubernetes_config_map" "api-host" {
  depends_on = [
    kubernetes_namespace.ui
  ]

  metadata {
    name      = "api-host"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-ui"
    }
  }

  data = {
    api_host = "http://${data.kubernetes_service.api-service-info.load_balancer_ingress.0.hostname}:${data.kubernetes_service.api-service-info.spec.port.port}"
  }
}

resource "kubernetes_deployment" "ui-deployment" {

  metadata {
    name      = "ui-deployment"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-ui"
    }
  }

  spec {
    replicas = var.ui_replicas
    selector {
      match_labels = {
        app = "devops7220-final-ui"
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
          app = "devops7220-final-ui"
        }
        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/path"   = "/metrics"
          "prometheus.io/port"   = "3000"
        }
      }

      spec {
        container {
          image = var.ui_image
          name  = "ui-container"
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
            config_map_ref {
              name = "api-host"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 10
            period_seconds        = 100
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "ui-service" {
  depends_on = [
    kubernetes_deployment.ui-deployment
  ]

  metadata {
    name      = "ui-service"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-ui"
    }
  }
  spec {
    selector = {
      #   app = "${kubernetes_deployment.api.spec[0].selector[0].match_labels.app}"
      app = "devops7220-final-ui"
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}
