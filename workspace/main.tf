resource "vpc" "ntier-vpc" {
  cidr_block =  var.ntier-vpc
  tags = {
    Name = "ntier-vpc"
    Env = terraform.workspace
  }
}