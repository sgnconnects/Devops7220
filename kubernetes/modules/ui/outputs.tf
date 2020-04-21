output "ui_host" {
  value = "http://${kubernetes_service.ui-service.load_balancer_ingress[0].hostname}:3000"
  depends_on = [
    kubernetes_service.ui-service
  ]
}