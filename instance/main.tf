provider "aws" {
  region = var.region
}
## creating vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_info.vpc_cidr
  tags = {
    Name = "ntier_vpc"
  }
}
## creating subnet
resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.vpc_info.cidr_block
  depends_on = [
    aws_vpc.vpc
  ]

}
## creating internetgate_way
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}
## creating route_table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "igw"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}
## creating route_table association
resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
  depends_on = [
    aws_route_table.route_table
  ]

}


## create security group
resource "aws_security_group" "sg" {
  name        = "allow ports"
  vpc_id      = aws_vpc.vpc.id
  description = "allow all ports"
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  depends_on = [
    aws_subnet.subnet
  ]
}

## create EC2 instance
resource "aws_instance" "compute-engine" {
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  ami                         = "ami-09744628bed84e434"
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  key_name                    = "compute"
  tags = {
    Name = "compute-engine"
  }
  depends_on = [
    aws_security_group.sg
  ]
}