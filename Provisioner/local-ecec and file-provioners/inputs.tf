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
}


variable "application-network-info" {
  type = object({
    region = string
    vpc_cidr = string
    subnet_names = list(string)
    subnet_azs = list(string)
    public_key_path = string
    private_key_path = string
    ami_id = string
    instance_size = string

  })
}


