variable "region" {
    type = string
    default = "eu-west-2"
}
variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "ntier_availability_zones" {
    type = list(string)
    default = [ "a","b","c","a" ]
}

variable "ntier_tag_names" {
  type = list(string)
  default = [ "subnet-1","subnet-2","subnet-3","subnet-4" ]
}
