resource "kubernetes_config_map" "prometheus-server-config" {
  metadata {
    name      = "prometheus-server-config"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-prometheus"
    }
  }

  data = {
    "prometheus.rules" = "${file("${path.module}/../files/prometheus-rules.yml")}"
    "prometheus.yml"   = "${file("${path.module}/../files/prometheus.yml")}"
  }
}
