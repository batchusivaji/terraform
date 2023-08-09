variable "region" {
    type = string
    default = "eu-west-2"
}
variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "ntier_subnet_ranges" {
    type = list(string)
    default = ["10.10.0.0/24","10.10.1.0/24","10.10.2.0/24","10.10.3.0/24"]
  
}

variable "ntier_availability_zones" {
    type = list(string)
    default = [ "a","b","c","a" ]
}

variable "ntier_tag_names" {
  type = list(string)
  default = [ "subnet-1","subnet-2","subnet-3","subnet-4" ]
}
