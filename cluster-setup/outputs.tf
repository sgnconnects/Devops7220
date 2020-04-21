# outputs from cluster-vpc module
output "vpc_id" {
  value = "${module.cluster-vpc.vpc_id}"
}

output "subnet_ids" {
  value = "${module.cluster-vpc.subnet_ids}"
}

# outputs from cluster module
output "config_map_aws_auth" {
  value = "${module.cluster.config_map_aws_auth}"
}

output "kubeconfig" {
  value = "${module.cluster.kubeconfig}"
}

output "kubeversion" {
  value = "${module.cluster.kubeversion}"
}