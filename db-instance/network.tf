resource "aws_vpc" "ntier_vpc" {
  cidr_block = var.vpc_network_cidr
  tags = {Name = "ntier-vpc"}
}



resource "aws_subnet" "subnets" {
  count             = length(var.subnet_names)
  vpc_id            = aws_vpc.ntier_vpc.id
  cidr_block        = cidrsubnet(var.vpc_network_cidr, 8, count.index)
  availability_zone = var.subnet_azs[count.index]
  tags = {Name = var.subnet_names[count.index]}
  depends_on = [
    aws_vpc.ntier_vpc
  ]
}




