network_info = {
   name = "app"
   cidr_range = "192.168.0.0/16"
   region = "us-east-1"
}
public_subnets = {
   name = [ "app-subnet-1", "app-subnet-2" ]
   cidr_range = [ "192.168.0.0/24" , "192.168.1.0/24" ]
   azs = [ "a", "b"]
} 

private_subnets = {
  name = [ "db-subnet-1", "db-subnet-2" ]
  cidr_range = [ "192.168.2.0/24", "192.168.3.0/24" ]
  azs = [ "b" , "a"]
} 

