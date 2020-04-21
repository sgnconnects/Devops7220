# data source to fetch the latest Amazon Machine Image (AMI) that Amazon provides 
# with an EKS compatible Kubernetes baked in. It will filter for and select an AMI 
# compatible with the specific Kubernetes version being deployed

data "aws_ami" "devops7220-eks-cluster-worker-node" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.devops7220-eks-cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID

  depends_on = [
    aws_eks_cluster.devops7220-eks-cluster
  ]
}