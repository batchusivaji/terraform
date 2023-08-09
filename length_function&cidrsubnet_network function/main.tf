provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnets" {
    count = length(var.ntier_tag_names)
    vpc_id = aws_vpc.ntier.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = "${var.region}${var.ntier_availability_zones[count.index]}"
    tags = {
      Name = var.ntier_tag_names[count.index]
    }
}