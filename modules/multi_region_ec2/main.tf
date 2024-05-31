module "vpc" {
    source = "github.com/terraform/modules/resources/vpc"
    network_info = {
        name = "vpc"
        cidr = "10.0.0.0/16"
    }
    subnet_info = [{
        name = "subnet-1"
        cidr = "10.0.0.0/24"
        az = "us-east-1a"
},
   {
        name = "subnet-2"
        cidr = "10.0.1.0/24"
        az = "us-east-1b"
    }]
}

# create security group

module "securitygroup_info" {
  source = "github.com/terraform/modules/resources/securitygroup"
  security_group_info = {
    name = "sg"
    vpc_id = module.vpc.id
    inbound_rules = [{
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH"
    },
    {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP"
    }
    ]
    outbound_rules = [{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
   }]
  }
}
# create a ami 
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "ami"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["533267075021"]
}
# create instance

module "instance" {
  source = "github.com/terraform/modules/resources/ec2"
  instance_info = {
    name = "ec2-1"
    ami = data.aws_ami.id
    instance_type = "t2.micro"
    key_name = "mykey"
    subnet_id = module.subnet_info[0].id
    associate_public_ip_address = true
     security_group_id           = module.security_group_info
  }
}