#
# EKS Worker Nodes Resources
#  * EC2 Security Group to allow networking traffic
#

resource "aws_security_group" "devops7220-eks-cluster-worker-node-sg" {
  description = "Security group for all worker nodes in the cluster"
  name        = "devops7220-eks-cluster-worker-node-sg"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = map(
    "Name", "devops7220-eks-cluster-worker-node-sg",
    "kubernetes.io/cluster/${var.cluster-name}", "owned",
  )
}

resource "aws_security_group_rule" "devops7220-eks-cluster-worker-node-sg-ingress-self" {
  description              = "Allow worker nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.devops7220-eks-cluster-worker-node-sg.id}"
  source_security_group_id = "${aws_security_group.devops7220-eks-cluster-worker-node-sg.id}"
  to_port                  = 65535
  type                     = "ingress"
  depends_on = [
    aws_security_group.devops7220-eks-cluster-worker-node-sg
  ]
}

resource "aws_security_group_rule" "devops7220-eks-cluster-worker-node-sg-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.devops7220-eks-cluster-worker-node-sg.id}"
  source_security_group_id = "${aws_security_group.devops7220-eks-cluster-sg.id}"
  to_port                  = 65535
  type                     = "ingress"
  depends_on = [
    aws_security_group.devops7220-eks-cluster-worker-node-sg,
    aws_security_group.devops7220-eks-cluster-sg
  ]
}
