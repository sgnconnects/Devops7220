resource "kubernetes_deployment" "kube-state-deployment" {
  depends_on = [
    kubernetes_service_account.kube-state-svc-ac
  ]

  metadata {
    name      = "kube-state-deployment"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-kube-state"
    }
  }

  spec {
    replicas = var.kube_state_replicas
    selector {
      match_labels = {
        app = "devops7220-final-kube-state"
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
          app = "devops7220-final-kube-state"
        }
      }

      spec {
        service_account_name            = "kube-state-svc-ac"
        automount_service_account_token = true
        container {
          name  = "kube-state-container"
          image = "quay.io/coreos/kube-state-metrics:v1.8.0"
          port {
            container_port = 8080
            name           = "http-metrics"
          }
          port {
            container_port = 8081
            name           = "telemetry"
          }
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 8081
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}
