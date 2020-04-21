resource "aws_iam_role" "devops7220-eks-cluster-role" {
  name = "devops7220-eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "devops7220-eks-cluster-role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.devops7220-eks-cluster-role.name}"
  depends_on = [
    aws_iam_role.devops7220-eks-cluster-role
  ]
}

resource "aws_iam_role_policy_attachment" "devops7220-eks-cluster-role-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.devops7220-eks-cluster-role.name}"
  depends_on = [
    aws_iam_role.devops7220-eks-cluster-role
  ]
}
