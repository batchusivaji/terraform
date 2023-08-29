variable "application-network-info" {
  type = object({
    region = string,
    vpc_cidr = string,
    subnet_names = list(string),
    public_subnets = list(string),
    private_subnets = list(string),
    subnet_azs = list(string),
    public_key_path = string,
    private_key_path = string,
    ami_id = string,
    instance_size = string
  })
  default = {
    region = "ap-northeast-2"
    vpc_cidr = "10.10.0.0/16"
    subnet_names = [ "app-subnet-1","app-subnet-2","web-subnet-1","web-subnet-2" ]
    public_subnets = ["app-subnet-1","app-subnet-2"]
    private_subnets =  ["web-subnet-1","web-subnet-2"]
    subnet_azs =  ["a","c","b","a"]
    public_key_path = "~/.ssh/id_rsa.pub"
    private_key_path = "~/.ssh/id_rsa"
    ami_id = "ami-0c9c942bd7bf113a2"
    instance_size = "t2.micro"
    
  }
}

variable "application_sg_config" {
  type = object({
    name = string
    description = string
    rules = list(object({
      type = string
      from_port = number
      to_port = number
      protocol = string
      cidr_block = string
    }))
  })
 default = {
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
              from_port   = 0
              to_port     = 65535
              protocol    = "-1"
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
            to_port = 65535
            protocol = "-1"
            cidr_block = "0.0.0.0/0"
        }
    ]
     

 }
}



  


