resource "kubernetes_deployment" "prometheus-deployment" {
  depends_on = [
    kubernetes_config_map.prometheus-server-config,
    kubernetes_service_account.prometheus-svc-ac
  ]

  metadata {
    name      = "prometheus-deployment"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-prometheus"
    }
  }

  spec {
    replicas = var.prometheus_replicas
    selector {
      match_labels = {
        app = "devops7220-final-prometheus"
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
          app = "devops7220-final-prometheus"
        }
      }

      spec {
        service_account_name = "prometheus-svc-ac"
        automount_service_account_token = true
        container {
          name  = "prometheus-container"
          image = "prom/prometheus:v2.12.0"
          args = [
            "--config.file=/etc/prometheus/prometheus.yml",
            "--storage.tsdb.path=/prometheus/"
          ]
          port {
            container_port = 9090
          }

          volume_mount {
            name       = "prometheus-config-volume"
            mount_path = "/etc/prometheus/"
          }
          volume_mount {
            name       = "prometheus-storage-volume"
            mount_path = "/prometheus/"
          }
        }

        volume {
          name = "prometheus-config-volume"
          config_map {
            # default_mode = "0420"
            name = "prometheus-server-config"
          }
        }
        volume {
          name = "prometheus-storage-volume"
          empty_dir {}
        }
      }
    }
  }
}
