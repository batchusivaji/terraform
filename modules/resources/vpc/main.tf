provider "aws" {
  region = var.network_info.region
}
resource "aws_vpc" "network-vpc1" {
  cidr_block = var.network_info.cidr_range_1
  tags = {Name = var.network_info.name1}
}
resource "aws_vpc" "network-vpc2" {
  cidr_block = var.network_info.cidr_range_2
  tags = {Name = var.network_info.name2}
}

#subnets
resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.network.id
  cidr_block = var.network_info.private_subnets.subnet1_cidr_range
  availability_zone = "${var.network_info.region}${var.network_info.private_subnets.azs}"
  tags = {Name = var.network_info.private_subnets.name}
  depends_on = [ aws_vpc.network ]
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.network.id
  cidr_block = var.network_info.public_subnets.subnet2_cidr_range
  availability_zone = "${var.network_info.region}${var.network_info.public_subnets.azs}"
  tags = {Name = var.network_info.public_subnets.name}
  depends_on = [ aws_vpc.network ]
}

#create internet gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.network.id
  tags = {Name = var.network_info.igw_name}
}

#create a public route table
 resource "aws_route_table" "public" {
   vpc_id = aws_vpc.network.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {Name = var.network_info.rt_name}
  depends_on = [ aws_vpc.network , aws_internet_gateway.gateway ]
   }
#associate public subnets with public route table
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public[0].id
  route_table_id = aws_route_table.public.id
  depends_on = [ aws_subnet.public, aws_route_table.public]
}

# create pemkey
resource "aws_key_pair" "public-key" {
  key_name   = "key-pair"
  public_key = file(var.network_info.public_key_path)
}