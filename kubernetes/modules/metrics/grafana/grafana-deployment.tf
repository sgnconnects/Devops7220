resource "kubernetes_deployment" "grafana-deployment" {
  depends_on = [
    kubernetes_config_map.grafana-datasources-config
  ]

  metadata {
    name      = "grafana-deployment"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-grafana"
    }
  }

  spec {
    replicas = var.grafana_replicas
    selector {
      match_labels = {
        app = "devops7220-final-grafana"
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
          app = "devops7220-final-grafana"
        }
      }

      spec {
        container {
          name  = "grafana-container"
          image = "grafana/grafana:latest"
          port {
            container_port = 3000
          }

          volume_mount {
            name       = "grafana-storage"
            mount_path = "/var/lib/grafana"
          }
          volume_mount {
            name       = "grafana-datasources"
            mount_path = "/etc/grafana/provisioning/datasources"
            read_only  = false
          }
        }

        volume {
          name = "grafana-datasources"
          config_map {
            # default_mode = "0420"
            name = "grafana-datasources-config"
          }
        }
        volume {
          name = "grafana-storage"
          empty_dir {}
        }
      }
    }
  }
}
