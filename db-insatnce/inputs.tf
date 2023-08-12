variable "region" {
  type = string
  default = "ap-south-1"
}

variable "ntier-vpc" {
  type = string
  default = "192.168.0.0/16"
}

variable "ntier-subnet" {
  type = string
  default = "192.168.0.0/24"
}