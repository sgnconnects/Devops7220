resource "kubernetes_service_account" "kube-state-svc-ac" {
  metadata {
    name      = "kube-state-svc-ac"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-kube-state"
    }
    annotations = {
      "app.kubernetes.io/name"    = "kube-state-svc-ac"
      "app.kubernetes.io/version" = "v1.8.0"
    }
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "kube-state-role" {
  metadata {
    name = "kube-state-role"
    labels = {
      app = "devops7220-final-kube-state"
    }
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps", "secrets", "nodes", "pods", "services", "resourcequotas", "replicationcontrollers", "limitranges", "persistentvolumeclaims", "persistentvolumes", "namespaces", "endpoints"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["daemonsets", "deployments", "replicasets", "ingresses"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["statefulsets", "daemonsets", "deployments", "replicasets"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["cronjobs", "jobs"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources  = ["horizontalpodautoscalers"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["authorization.k8s.io"]
    resources  = ["tokenreviews"]
    verbs      = ["create"]
  }

  rule {
    api_groups = ["authorization.k8s.io"]
    resources  = ["subjectaccessreviews"]
    verbs      = ["create"]
  }

  rule {
    api_groups = ["policy"]
    resources  = ["poddisruptionbudgets"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources  = ["certificatesigningrequests"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses", "volumeattachments"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["admissionregistration.k8s.io"]
    resources  = ["mutatingwebhookconfigurations", "validatingwebhookconfigurations"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["networkpolicies"]
    verbs      = ["list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "kube-state-role-binding" {
  depends_on = [
    kubernetes_cluster_role.kube-state-role,
    kubernetes_service_account.kube-state-svc-ac
  ]
  metadata {
    name = "kube-state-role-binding"
    labels = {
      app = "devops7220-final-kube-state"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "kube-state-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kube-state-svc-ac"
    namespace = var.namespace
  }
}
