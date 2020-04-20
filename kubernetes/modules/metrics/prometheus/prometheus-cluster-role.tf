resource "kubernetes_service_account" "prometheus-svc-ac" {
  metadata {
    name      = "prometheus-svc-ac"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-prometheus"
    }
  }

  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "prometheus-role" {
  metadata {
    name = "prometheus-role"
    labels = {
      app = "devops7220-final-prometheus"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "nodes/proxy", "services", "endpoints", "pods"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    non_resource_urls = ["/metrics"]
    verbs             = ["get"]
  }
}

resource "kubernetes_cluster_role_binding" "prometheus-role-binding" {
  depends_on = [
    kubernetes_cluster_role.prometheus-role,
    kubernetes_service_account.prometheus-svc-ac
  ]
  metadata {
    name = "prometheus-role-binding"
    labels = {
      app = "devops7220-final-prometheus"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "prometheus-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "prometheus-svc-ac"
    namespace = var.namespace
  }
}
