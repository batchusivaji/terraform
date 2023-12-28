# Create VPC
resource "aws_vpc" "ntier-vpc" {
  cidr_block = var.application-network-info.vpc_cidr
  tags       = { Name = "ntier-vpc" }
}
# Create Subnets 
resource "aws_subnet" "ntier-subnets" {
  count             = length("${var.application-network-info.subnet_names}")
  vpc_id            = local.vpc_id
  cidr_block        = cidrsubnet("${var.application-network-info.vpc_cidr}", 8, count.index)
  availability_zone = "${var.application-network-info.region}${var.application-network-info.subnet_azs[count.index]}"
  tags              = { Name = "${var.application-network-info.subnet_names}" [count.index] }
  depends_on        = [aws_vpc.ntier-vpc]
}
# find out private subnets
data "aws_subnets" "private-subnets" {
  filter {
    name   = "vpc-id"
    values = var.application-network-info.private_subnets
  }
  filter {
    name   = "tag:Name"
    values = ["${local.vpc_id}"]
  }
}
# find out public subnets
data "aws_subnets" "public-subnets" {
  filter {
    name   = "vpc-id"
    values = var.application-network-info.public_subnets
  }
  filter {
    name   = "tag:Name"
    values = ["${local.vpc_id}"]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id     = local.vpc_id
  tags       = { Name = "igw" }
  depends_on = [aws_vpc.ntier-vpc]
}
# Route table for public subnets
resource "aws_route_table" "rt" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "rt-public" }
}
# Route table association for public subnets
resource "aws_route_table_association" "public-subnet-association" {
  #count = length(data.aws_subnets.public-subnets.ids)
  count          = 1
  subnet_id      = data.aws_subnets.public-subnets.ids[count.index]
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_subnet.ntier-subnets, aws_route_table.rt]
}

# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "eip" {
  vpc = true
}
## Create a NAT gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  #subnet_id = aws_subnet.ntier-subnets[0].id
  connectivity_type = "public"
  subnet_id         = element(var.application-network-info.private_subnets, 1)
  depends_on        = [aws_internet_gateway.igw, aws_subnet.ntier-subnets]
}
## Route table private subnets 
resource "aws_route_table" "rt-private" {
  vpc_id = local.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags       = { Name = "rt-private" }
  depends_on = [aws_nat_gateway.ngw]
}
# subnet association
resource "aws_route_table_association" "private-subnets-association" {
  #count = length(data.aws_subnets.private-subnets.ids)
  count     = 1
  subnet_id = data.aws_subnets.private-subnets.ids[count.index]
  #for_each = data.aws_subnets.private-subnets.ids
  #subnet_id = each.key
  # subnet_id = "${element(var.application-network-info.private_subnets, 1)}"
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_subnet.ntier-subnets, aws_route_table.rt-private]
}

## Create a keypair
resource "aws_key_pair" "public-key" {
  key_name   = "key_pair_gataway"
  public_key = file(var.application-network-info.public_key_path)
}

