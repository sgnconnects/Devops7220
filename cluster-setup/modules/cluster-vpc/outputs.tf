output "vpc_id" {
  value = "${aws_vpc.devops7220-eks-cluster-vpc.id}"
}

output "subnet_ids" {
  value = "${aws_subnet.devops7220-eks-cluster-subnets.*.id}"
}