data "aws_subnets" "db" {
  filter {
    name = "tag:Name"
    values = var.db_subnet_names
  }
  depends_on = [ aws_subnet.subnets ]
}

resource "aws_db_subnet_group" "db-subnets" {
   name = "subnet-group"
   subnet_ids = data.aws_subnets.db.ids
   tags = {Name = "db-subnnet-group"}
}


resource "aws_db_instance" "db-instance" {
   allocated_storage  = 20
   db_name = "empdb"
   engine = "mysql"   
   engine_version = "8.0"  
  instance_class = "db.t3.micro"  
   username = "root"   
   password = "rootroot" 
   skip_final_snapshot  = true
   db_subnet_group_name  =  aws_db_subnet_group.db-subnets.name  
   vpc_security_group_ids = [aws_security_group.dbsg.id]
}