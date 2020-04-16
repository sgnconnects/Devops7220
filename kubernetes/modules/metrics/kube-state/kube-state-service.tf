resource "kubernetes_service" "kube-state-service" {
  depends_on = [
    kubernetes_deployment.kube-state-deployment
  ]
  metadata {
    name      = "kube-state-service"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-kube-state"
    }
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "9090"
    }
  }
  spec {
    selector = {
      app = "devops7220-final-kube-state"
    }
    port {
      name        = "http-metrics"
      port        = 8080
      target_port = "http-metrics"
    }
    port {
      name        = "telemetry"
      port        = 8081
      target_port = "telemetry"
    }
    cluster_ip = "None"
  }
}
