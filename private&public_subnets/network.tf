### create VPC
resource "aws_vpc" "ntier-vpc" {
  cidr_block = var.ntier-vpc-info.vpc_cidr
  tags = {Name = "ntier-vpc"}
}
### create Subnets
resource "aws_subnet" "ntier-subnets" {
  count = length(var.ntier-vpc-info.subnet-tag-names)
  vpc_id = local.vpc_id
  cidr_block = cidrsubnet(var.ntier-vpc-info.vpc_cidr, 8,count.index)
  availability_zone = "${var.region}${var.ntier-vpc-info.subnet-availabity-zones[count.index]}"
  tags = { Name =var.ntier-vpc-info.subnet-tag-names[count.index] }
  depends_on = [ aws_vpc.ntier-vpc ]
}

### create Internet Gateway

resource "aws_internet_gateway" "ig" {
  vpc_id = local.vpc_id
  tags = {Name = "ig"}
  depends_on = [ aws_vpc.ntier-vpc ]
}
### create a Route Table

resource "aws_route_table" "private" {
   vpc_id = local.vpc_id 

   tags = { Name = "private-route-table"}
   depends_on = [ aws_subnet.ntier-subnets]
}

resource "aws_route_table" "public" {
   vpc_id = local.vpc_id 

   route {
     cidr_block = local.anywhere
     gateway_id = aws_internet_gateway.ig.id 
   }
   tags = { Name = "public-route-table"}
   depends_on = [ aws_subnet.ntier-subnets]
}

  data "aws_subnets" "private" {
    filter {
      name = "vpc-id"
      values = var.ntier-vpc-info.private-subnets
    }
    filter {
      name = "tag:Name"
      values = [local.vpc_id]
    }
    depends_on = [aws_subnet.ntier-subnets]
  }

  data "aws_subnets" "public" {
    filter {
      name = "vpc-id"
      values = var.ntier-vpc-info.public-subnets
    
    }

  filter {
    name = "tag:Name"
    values = [local.vpc_id]
      }
      depends_on = [ aws_subnet.ntier-subnets]
  }

  
   resource "aws_route_table_association" "private" {
    count = length(data.aws_subnets.private.ids)
    route_table_id = aws_route_table.private.id
    subnet_id = data.aws_subnets.private.ids[count.index]
   depends_on = [ aws_subnet.ntier-subnets ,aws_route_table.private]
      }

  resource "aws_route_table_association" "public" {
    count = length(data.aws_subnets.public.ids)
    route_table_id = aws_route_table.public.id
    subnet_id = data.aws_subnets.public.ids[count.index]
    depends_on = [ aws_route_table.public,aws_route_table.public ]
   
  }
