output "api_host" {
  value = "http://${kubernetes_service.api-service.load_balancer_ingress[0].hostname}:5000"
  depends_on = [
    kubernetes_service.api-service
  ]
}