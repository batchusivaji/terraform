variable "region" {
    type = string
    default = "ap-south-1"
}


variable "ntier_vpc_info" {
    type = object({
      vpc_cidr = string,
      ntier_availability_zones = list(string),
      ntier_tag_names = list(string)
    })
    default = {
       ntier_availability_zones =  [ "a","b","c","a" ]
       ntier_tag_names =  [ "subnet-1","subnet-2","subnet-3","subnet-4" ]
       vpc_cidr = "10.10.0.0/16"
    }
}

