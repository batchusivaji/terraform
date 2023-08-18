variable "region" {
  type    = string
  default = "eu-west-2"

}

variable "ntier-vpc-info" {
  type = object({
    vpc_cidr                  = string,
    subnet-availability_zones = list(string),
    subnet-tag-names          = list(string)
  })
  default = {
    vpc_cidr                  = "10.10.0.0/16"
    subnet-availability_zones = ["a", "b", "c"]
    subnet-tag-names          = ["ntier-subnet-1", "ntier-subnet-2", "ntier-subnet-3"]
  }
}


