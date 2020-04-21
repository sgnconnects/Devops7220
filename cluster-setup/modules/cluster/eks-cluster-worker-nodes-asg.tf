resource "aws_autoscaling_group" "devops7220-eks-cluster-worker-node-asg" {
  desired_capacity     = 1
  launch_configuration = "${aws_launch_configuration.devops7220-eks-cluster-worker-node-launch-config.id}"
  max_size             = 3
  min_size             = 1
  name                 = "devops7220-eks-cluster-worker-node-asg"
  vpc_zone_identifier  = "${var.subnet_ids}"

  tag {
    key                 = "Name"
    value               = "devops7220-eks-cluster-worker-node"
    propagate_at_launch = true
  }
  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
  # tag {
  #   key                 = "k8s.io/cluster-autoscaler/${var.cluster-name}"
  #   value               = "owned"
  #   propagate_at_launch = true
  # }
  # tag {
  #   key                 = "k8s.io/cluster-autoscaler/enabled"
  #   value               = "true"
  #   propagate_at_launch = true
  # }
  # tag {
  #   key                 = "service"
  #   value               = "k8s_node"
  #   propagate_at_launch = true
  # }

  depends_on = [
    aws_launch_configuration.devops7220-eks-cluster-worker-node-launch-config,
    aws_eks_cluster.devops7220-eks-cluster
  ]
}
