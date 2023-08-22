provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier-vpc" {
  cidr_block = var.ntier-vpc
  tags = {
    Name = ntier-vpc
    Env = terraform.workspace
  }
}
