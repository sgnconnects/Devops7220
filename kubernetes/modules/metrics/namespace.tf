resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace
  }
}

module "kube-state" {
  source           = "./kube-state"
  namespace        = var.namespace
  kube_state_replicas = var.kube_state_replicas
}

module "prometheus" {
  source              = "./prometheus"
  namespace           = var.namespace
  prometheus_replicas = var.prometheus_replicas
}

module "grafana" {
  source           = "./grafana"
  namespace        = var.namespace
  grafana_replicas = var.grafana_replicas
}
