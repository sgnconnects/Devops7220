variable "aws-profile" {
  default = "default"
  type    = string
}

provider "aws" {
  region  = "us-east-1"
  profile = "${var.aws-profile}"
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}

module "cluster-vpc" {
  source       = "./modules/cluster-vpc"
  cluster-name = "${var.cluster-name}"
  availability-zones = "${data.aws_availability_zones.available}"
}

module "cluster" {
  source       = "./modules/cluster"
  cluster-name = "${var.cluster-name}"
  vpc_id = "${module.cluster-vpc.vpc_id}"
  subnet_ids = "${module.cluster-vpc.subnet_ids}"
  aws-profile = "${var.aws-profile}"
}