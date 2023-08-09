provider "aws" {
  region = "us-east-1"
  alias  = "primary"
}

provider "aws" {
  region = "eu-west-2"
  alias  = "secondary"
}

resource "aws_vpc" "ntier1" {
  provider   = aws.primary
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "ntier-vpc-1"
  }
}

resource "aws_vpc" "ntier2" {
  provider   = aws.secondary
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "ntier-vpc-2"
  }
}


resource "aws_subnet" "ntier-subnet-1" {
  provider = aws.primary
  vpc_id     = aws_vpc.ntier1.id
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "ntier-subnet-1"
  }
  depends_on = [ aws_vpc.ntier1 ]
}


resource "aws_subnet" "ntier-subnet-2" {
  provider   = aws.secondary
  vpc_id     = aws_vpc.ntier2.id
  cidr_block = "10.10.0.0/24"
  tags = {
    Name = "ntier-subnet-2"
  }
  depends_on = [ aws_vpc.ntier2 ]
}

