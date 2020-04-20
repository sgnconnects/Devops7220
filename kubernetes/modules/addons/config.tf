data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "metrics-server" {
  name       = "metrics-server"
  repository = "${data.helm_repository.stable.metadata[0].name}"
  chart      = "metrics-server"
  version    = "2.11.1"
  namespace = "kube-system"

  set {
    name = "rbac.create"
    value = "true"
  }
  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }
  set {
    name  = "args[1]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }
  set {
    name  = "args[2]"
    value = "--v=2"
  }
  set {
    name  = "args[3]"
    value = "--deprecated-kubelet-completely-insecure"
  }
  set {
    name  = "args[4]"
    value = "--kubelet-port=10255"
  }
}

resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler"
  repository = "${data.helm_repository.stable.metadata[0].name}"
  chart      = "cluster-autoscaler"
  version    = "7.2.2"
  namespace = "kube-system"

  set {
    name = "sslCertHostPath"
    value = "/etc/ssl/certs/ca-bundle.crt"
  }
  set {
    name  = "autoDiscovery.clusterName"
    value = "${var.cluster-name}"
  }
  set {
    name  = "rbac.create"
    value = "true"
  }
  set {
    name  = "extraArgs.scale-down-enabled"
    value = "true"
  }
  set {
    name  = "extraArgs.balance-similar-node-groups"
    value = "true"
  }
}



resource "helm_release" "kubernetes-dashboard" {
  name       = "cluster-autoscaler"
  repository = "${data.helm_repository.stable.metadata[0].name}"
  chart      = "cluster-autoscaler"
  version    = "7.2.2"
  namespace = "kube-system"
}