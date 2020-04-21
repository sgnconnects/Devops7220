locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.devops7220-eks-cluster-worker-node-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG
apiVersion: v1
kind: Config
preferences: {}
clusters:
  - cluster:
      server: ${aws_eks_cluster.devops7220-eks-cluster.endpoint}
      certificate-authority-data: ${aws_eks_cluster.devops7220-eks-cluster.certificate_authority.0.data}
    name: kubernetes
users:
  - name: aws
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1alpha1
        command: aws
        args:
          - "eks"
          - "get-token"
          - "--cluster-name"
          - "${var.cluster-name}"
        env:
          - name: AWS_PROFILE
            value: "${var.aws-profile}"
contexts:
  - context:
      cluster: kubernetes
      user: aws
    name: eks
current-context: eks
KUBECONFIG
}

output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

output "kubeversion" {
  value = "${aws_eks_cluster.devops7220-eks-cluster.version}"
}
