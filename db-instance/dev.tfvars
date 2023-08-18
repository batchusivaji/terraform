vpc_network_cidr = "10.10.0.0/16"
subnet_names     = ["web1", "web2", "app1", "app2", "db1", "db2"]
db_subnet_names  = ["db1", "db2"]
subnet_azs       = ["eu-west-2a", "eu-west-2c", "eu-west-2b", "eu-west-2c", "eu-west-2b", "eu-west-2c"]

db_sg_config = {
  name        = "dbsg"
  description = "this is dbsecurity group"
  rules = [{
    type       = "ingress"
    from_port  = 3306
    to_port    = 3306
    protocol   = "tcp"
    cidr_block = "10.10.0.0/16"
    },
    {
      type       = "egress"
      from_port  = 0
      to_port    = 65535
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}
