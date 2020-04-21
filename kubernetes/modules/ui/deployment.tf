resource "kubernetes_namespace" "ui" {
  metadata {
    name = var.namespace
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
    REACT_APP_API_HOST = "${var.api_host}"
  }
}

resource "kubernetes_deployment" "ui-deployment" {
  depends_on = [
    kubernetes_config_map.api-host
  ]

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
        # annotations = {
        #   "prometheus.io/scrape" = "true"
        #   "prometheus.io/path"   = "/metrics"
        #   "prometheus.io/port"   = "3000"
        # }
      }

      spec {

        affinity {
          pod_anti_affinity {
            preferred_during_scheduling_ignored_during_execution {
              weight = 100
              pod_affinity_term {
                label_selector {
                  match_expressions {
                    key      = "app"
                    operator = "In"
                    values   = ["devops7220-final-ui"]
                  }
                }
                topology_key = "failure-domain.beta.kubernetes.io/zone"
              }
            }
          }
        }

        container {
          image = var.ui_image
          name  = "ui-container"
          resources {
            limits {
              cpu    = "200m"
              memory = "200Mi"
            }
            requests {
              cpu    = "100m"
              memory = "100m"
            }
          }

          env_from {
            config_map_ref {
              name = "api-host"
            }
          }

          # liveness_probe {
          #   http_get {
          #     path = "/"
          #     port = 3000
          #   }
          #   initial_delay_seconds = 10
          #   period_seconds        = 100
          # }

          # readiness_probe {
          #   http_get {
          #     path = "/"
          #     port = 3000
          #   }
          #   initial_delay_seconds = 10
          #   period_seconds        = 100
          # }
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
      app = "devops7220-final-ui"
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}
