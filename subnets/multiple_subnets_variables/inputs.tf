variable "region" {
    type = string
    default = "eu-west-2"
    description = "region to create rources"
  
}

variable "ntier_vpc_range" {
    type = string
    default = "10.10.0.0/16"
    
    description = "Vpc cidr Range"
  
}

variable "ntier_sunbet1_range" {
  
  type = string
  default = "10.10.0.0/24"
  description = "Subnet1 cidr range"
}

variable "ntier_subnet2_range" {
    type = string
    default = "10.10.1.0/24"
    description = "subnet2 cidr range"
  
}


variable "ntier_subnet3_range" {
    type = string
    default = "10.10.2.0/24"
    description = "subnet3 cidr range"
  
}

variable "ntier_vpc_name" {
    type = string
    default = "vpc"
    description = "vpc tag name"
  }

variable "ntier_tag1_name" {
    type = string
    default = "subnet1"
    description = "subnet1 tag name"
  
}

variable "ntier_tag2_name" {
    type = string
    default = "subnet2"
    description = "subnet2 tag name"
  
}

variable "ntier_tag3_name" {
  type = string
  default = "subnet3"
  description = "subnet3 tag name"
}

variable "first_availability_zone" {
    type = string
    default = "a"
  
}

variable "second_availability_zone" {
    type = string
    default = "b"
  
}

variable "third_availability_zone" {
    type = string
    default = "c"
  
}