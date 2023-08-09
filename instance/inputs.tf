variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "variable for to change required region"
}
## variable for vpc cidr
variable "vpc_info" {
  type = object({
    vpc_cidr        = string,
    cidr_block      = string,
    subnet_name     = string,
    subnet_name_az  = string
   
  })
  default = {
    subnet_name     = "ntier-subnet-1"
    vpc_cidr        = "100.100.0.0/16"
    cidr_block      = "100.100.0.0/24"
    subnet_name_az  = "a"
    
  }
}