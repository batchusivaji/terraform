variable "region" {
  type = string
  default = "eu-west-2"
}

variable "vpc_network_cidr" {
  type = string
  description = "this is network cidr"
}

variable "subnet_names" {
  type = list(string)
  default = [ "app1","app2","db1","db2","web1","web2" ]
  description = "these are subnet names"
}

variable "subnet_azs" {
  type = list(string)
  description = "these are availability zones"
}

variable "db_subnet_names" {
  type = list(string)
  default = [ "db1","db2" ]
  description = "these are db subnet names"
}

variable "db_sg_config" {
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
  description = "this is db security group"
}



