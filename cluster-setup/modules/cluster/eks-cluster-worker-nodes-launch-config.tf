# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  worker-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.devops7220-eks-cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.devops7220-eks-cluster.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
  depends_on = [
    aws_eks_cluster.devops7220-eks-cluster
  ]
}

resource "aws_launch_configuration" "devops7220-eks-cluster-worker-node-launch-config" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.devops7220-eks-cluster-worker-node-instance-profile.name}"
  image_id                    = "${data.aws_ami.devops7220-eks-cluster-worker-node.id}"
  instance_type               = "t2.large"
  name_prefix                 = "devops7220-eks-cluster-worker-node"
  security_groups             = ["${aws_security_group.devops7220-eks-cluster-worker-node-sg.id}"]
  user_data_base64            = "${base64encode(local.worker-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_security_group.devops7220-eks-cluster-worker-node-sg,
    data.aws_ami.devops7220-eks-cluster-worker-node,
    aws_iam_instance_profile.devops7220-eks-cluster-worker-node-instance-profile
  ]
}