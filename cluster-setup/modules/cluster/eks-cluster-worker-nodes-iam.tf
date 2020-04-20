#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#

resource "aws_iam_role" "devops7220-eks-cluster-worker-node-role" {
  name = "devops7220-eks-cluster-worker-node-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# data "aws_iam_policy_document" "as-policy-document" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "autoscaling:DescribeAutoScalingGroups",
#       "autoscaling:DescribeAutoScalingInstances",
#       "autoscaling:DescribeLaunchConfigurations",
#       "autoscaling:DescribeTags",
#       "autoscaling:SetDesiredCapacity",
#       "autoscaling:TerminateInstanceInAutoScalingGroup",
#       "ec2:DescribeLaunchTemplateVersions"
#     ]

#     resources = [
#       "*"
#     ]
#   }
# }

# resource "aws_iam_policy" "as-policy" {
#   name   = "devops7220-eks-cluster-worker-node-as-policy"
#   path   = "/"
#   policy = "${data.aws_iam_policy_document.as-policy-document.json}"
# }

# resource "aws_iam_role_policy_attachment" "devops7220-eks-cluster-worker-node-role-as-policy" {
#   policy_arn = "${aws_iam_policy.as-policy.arn}"
#   role       = "${aws_iam_role.devops7220-eks-cluster-worker-node-role.name}"
#   depends_on = [
#     aws_iam_role.devops7220-eks-cluster-worker-node-role
#   ]
# }

resource "aws_iam_role_policy_attachment" "devops7220-eks-cluster-worker-node-role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.devops7220-eks-cluster-worker-node-role.name}"
  depends_on = [
    aws_iam_role.devops7220-eks-cluster-worker-node-role
  ]
}

resource "aws_iam_role_policy_attachment" "devops7220-eks-cluster-worker-node-role-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.devops7220-eks-cluster-worker-node-role.name}"
  depends_on = [
    aws_iam_role.devops7220-eks-cluster-worker-node-role
  ]
}

resource "aws_iam_role_policy_attachment" "devops7220-eks-cluster-worker-node-role-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.devops7220-eks-cluster-worker-node-role.name}"
  depends_on = [
    aws_iam_role.devops7220-eks-cluster-worker-node-role
  ]
}

resource "aws_iam_instance_profile" "devops7220-eks-cluster-worker-node-instance-profile" {
  name = "devops7220-eks-cluster-worker-node-instance-profile"
  role = "${aws_iam_role.devops7220-eks-cluster-worker-node-role.name}"
  depends_on = [
    aws_iam_role.devops7220-eks-cluster-worker-node-role
  ]
}