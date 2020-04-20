resource "kubernetes_service" "prometheus-service" {
  depends_on = [
    kubernetes_deployment.prometheus-deployment
  ]
  metadata {
    name      = "prometheus-service"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-prometheus"
    }
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "9090"
    }
  }
  spec {
    selector = {
      app = "devops7220-final-prometheus"
    }
    port {
      port        = 8080
      target_port = 9090
      node_port   = 30000
    }
    type = "NodePort"
    # type = "LoadBalancer"
  }
}
