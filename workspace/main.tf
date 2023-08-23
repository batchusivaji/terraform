provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier-vpc" {
  cidr_block = var.ntier-vpc
  tags = {
    Name = format("ntier-%s",terraform.workspace)
    Env = terraform.workspace
  }
}
