resource "aws_security_group" "devops7220-eks-cluster-sg" {
  description = "Cluster communication with worker nodes"
  name        = "devops7220-eks-cluster-sg"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops7220-eks-cluster-sg"
  }
}

resource "aws_security_group_rule" "devops7220-eks-cluster-sg-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.devops7220-eks-cluster-sg.id}"
  source_security_group_id = "${aws_security_group.devops7220-eks-cluster-worker-node-sg.id}"
  to_port                  = 443
  type                     = "ingress"
  depends_on = [
    aws_security_group.devops7220-eks-cluster-sg,
    aws_security_group.devops7220-eks-cluster-worker-node-sg
  ]
}

resource "aws_security_group_rule" "devops7220-eks-cluster-sg-ingress-workstation-https" {
  description       = "Allow workstation to communicate with the cluster API Server"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.devops7220-eks-cluster-sg.id}"
  to_port           = 443
  type              = "ingress"
  depends_on = [
    aws_security_group.devops7220-eks-cluster-sg
  ]
}
