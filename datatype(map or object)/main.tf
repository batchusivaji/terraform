provider "aws" {
  region = var.region
}
 resource "aws_vpc" "ntier" {
   cidr_block = var.ntier_vpc_info.vpc_cidr
   tags = {
    Name = "ntier-vpc"
   }
 }
resource "aws_subnet" "subnets" {
    count = length(var.ntier_vpc_info.ntier_tag_names)
    vpc_id = aws_vpc.ntier.id
    cidr_block = cidrsubnet(var.ntier_vpc_info.vpc_cidr,8,count.index)
    availability_zone = "${var.region}${var.ntier_vpc_info.ntier_availability_zones[count.index]}"
    tags = {
      Name = var.ntier_vpc_info.ntier_tag_names[count.index]
    }

    depends_on = [ aws_vpc.ntier ]
}