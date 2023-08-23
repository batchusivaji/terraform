provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnets" {
    count = 4
    vpc_id = aws_vpc.ntier.id
    cidr_block = var.ntier_subnet_ranges[count.index]
    availability_zone = "${var.region}${var.ntier_availability_zones[count.index]}"
    tags = {
      Name = var.ntier_tag_names[count.index]
    }
}