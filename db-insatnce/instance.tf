  
provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier-vpc" {
  cidr_block = var.ntier-vpc
  tags = {Name = "ntier-vpc"}
}

resource "aws_subnet" "ntier-subnet" {
  vpc_id = aws_vpc.ntier-vpc.id
  cidr_block = var.ntier-subnet
  tags = {
    Name = "ntier-subnet"
    }
}


resource "aws_subnet" "ntier-subnet-1" {
  vpc_id = aws_vpc.ntier-vpc.id
  cidr_block = var.ntier-subnet
  tags = {Name = "ntier-subnet-1"}
}

resource " aws_db_subnet_group" "subnet-group" {
  name = "my-db-sg"
  subnet_ids = [aws_subnet.ntier-subnet.id,aws_subnet.ntier-subnet-1.id]
}


resource "aws_security_group" {
   name = "allow all ports"
   vpc_id = aws_vpc.ntier-vpc.id


  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  tags = {Name = "sg"}
}

resource "aws_db_instance" "db-instance" {
  allocated_storage = 20
  db_name = "mysqldb"
  engine = "mysql"
  db_subnet_group_name  = db_subnet_group.subnet-group.name
  engine_version       = "8.0.33"
  instance_class       = "db.t3.micro"
  username             = "adminadmin"
  password             = "adminadmin"
  skip_final_snapshot  = true



}