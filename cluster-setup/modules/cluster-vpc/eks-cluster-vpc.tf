resource "aws_vpc" "devops7220-eks-cluster-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "devops7220-eks-cluster",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "devops7220-eks-cluster-subnets" {
  count = 3

  # availability_zone = "${var.availability-zones.available.names[count.index]}"
  availability_zone = "${var.availability-zones.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.devops7220-eks-cluster-vpc.id}"

  tags = map(
    "Name", "devops7220-eks-cluster",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "devops7220-eks-cluster-igw" {
  vpc_id = "${aws_vpc.devops7220-eks-cluster-vpc.id}"

  tags = {
    Name = "devops7220-eks-cluster-igw"
  }
}

resource "aws_route_table" "devops7220-eks-cluster-rt" {
  vpc_id = "${aws_vpc.devops7220-eks-cluster-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.devops7220-eks-cluster-igw.id}"
  }
}

resource "aws_route_table_association" "devops7220-eks-cluster-rt-association" {
  count = 2

  subnet_id      = "${aws_subnet.devops7220-eks-cluster-subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.devops7220-eks-cluster-rt.id}"
}
