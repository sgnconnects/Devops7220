resource "kubernetes_config_map" "grafana-datasources-config" {
  metadata {
    name      = "grafana-datasources-config"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-grafana"
    }
  }

  data = {
    "prometheus.yml" = "${file("${path.module}/../files/grafana-prometheus.yml")}"
  }
}
