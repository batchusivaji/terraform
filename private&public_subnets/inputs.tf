variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "ntier-vpc-info" {
  type = object({
    vpc_cidr                = string,
    subnet-tag-names        = list(string),
    subnet-availabity-zones = list(string),
    private-subnets         = list(string),
    public-subnets          = list(string),
    db-subnets              = list(string)
  })

  default = {
    vpc_cidr                = "10.10.0.0/16"
    subnet-tag-names        = ["app1", "app2", "app3", "app4", "web1", "web2", "db1", "db2"]
    subnet-availabity-zones = ["a", "b", "c", "a", "b", "a", "b", "c"]
    private-subnets         = ["app1", "aap2", "app3", "app4"]
    public-subnets          = ["web1", "web2"]
    db-subnets              = ["db1", "db2"]
  }
}