application-vpc-info = {
vpc_cidr = "10.10.0.0/16"
subnet_names = [ "app-subnet-1","app-subnet-2","db-subnet-1","db-subnet-2","web-subnet-1","web-subnet-2" ]
subnet_azs = ["a","c","b","a","c","b"]
public_key_path = "~/.ssh/id_rsa.pub"
instance_size = "t2.micro"
ami_id = "ami-09744628bed84e434"
}
application_sg_config = {
    name = "application-sg"
    description = "this is application security group config"
    rules = [
        {
            type = "ingress"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_block = "0.0.0.0/0"
        },
         {
            type = "ingress"
            from_port = 8080
            to_port = 8080
            protocol = "tcp"
            cidr_block = "0.0.0.0/0"
        },
         {
            type = "egress"
            from_port = 0
            to_port = 655356
            protocol = "-1"
            cidr_block = "0.0.0.0/0"
        }
    ]
}