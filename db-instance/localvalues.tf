locals {
  vpc_id = aws_vpc.ntier_vpc.id
  anywhere = "0.0.0.0.0/0"
  cidr_block = ["10.10.0.0/16"]
}