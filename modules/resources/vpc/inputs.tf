variable "network_info" {
  type = object({
    name1 = string
    name2 = string
    cidr_range_1 = string
    cidr_range_2 = string
    region = string
    private_subnets = list(object({
      subnet1_cidr_range = string
      azs = list(string)
      name= string
    }))
    public_subnets = list(object({
    subnet2_cidr_range = string
    name= string
    azs = list(string)
    cidr_range = string
  }))
  igw_name=string
  rt_name=string
  public_key_path = string
  })
}


