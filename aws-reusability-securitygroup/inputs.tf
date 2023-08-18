variable "vpc_network_cidr" {
  type =  string
}

variable "subnet_names" {
  type = list(string)
}

variable "subnet_azs" {
  type = list(string)
}


variable "web_sg_config" {
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

   description = "this is web security group config"
}


variable "db_sg_config" {#
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
variable "app_sg_config" {
 type = object({
   name = string
   description = string
   rules = list(object({
     type = string
     from_port = number
     to_port = number
     protocol = string
     cidr_block =string
   }))
 })
description = "this is app security group"
}