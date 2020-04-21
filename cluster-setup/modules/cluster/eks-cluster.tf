resource "aws_eks_cluster" "devops7220-eks-cluster" {
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.devops7220-eks-cluster-role.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.devops7220-eks-cluster-sg.id}"]
    subnet_ids         = "${var.subnet_ids}"
  }

  depends_on = [
    aws_iam_role_policy_attachment.devops7220-eks-cluster-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.devops7220-eks-cluster-role-AmazonEKSServicePolicy
  ]
}
