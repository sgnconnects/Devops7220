resource "kubernetes_service" "grafana-service" {
  depends_on = [
    kubernetes_deployment.grafana-deployment
  ]
  metadata {
    name      = "grafana-service"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-grafana"
    }
  }
  spec {
    selector = {
      app = "devops7220-final-grafana"
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}
