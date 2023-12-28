provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier" {
    cidr_block = var.ntier_vpc_range
    tags = {
        Name = var.ntier_vpc_name
    }
  
}



resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.ntier.id # implicit dependecies
  cidr_block = var.ntier_sunbet1_range
  availability_zone = "${var.region}${var.second_availability_zone}"
  tags = {
    Name = var.ntier_tag1_name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.ntier.id  # implicit dependecies
  cidr_block = var.ntier_subnet2_range
  availability_zone = "${var.region}${var.second_availability_zone}"
  tags = {
    Name = var.ntier_tag2_name
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.ntier.id   # implicit dependecies
  cidr_block = var.ntier_subnet3_range
  availability_zone = "${var.region}${var.third_availability_zone}"
  tags = {
    Name = var.ntier_tag3_name
  }
}
