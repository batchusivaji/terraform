resource "aws_security_group" "sg" {
  name = var.security_group_info.name
  vpc_id = var.security_group_info.vpc_id
  description = var.security_group_info.description
  tags = {Name = var.security_group_info.name}
}

# inbound rules

resource "aws_security_group_rule" "sg_in" {
  count              = length(var.security_group_info.inbound_rules)
  security_group_id = aws_security_group.sg.id
  type               = var.security_group_info.inbound_rules[count.index].type
  cidr_blocks        = [var.security_group_info.inbound_rules[count.index].cidr] // Use cidr_blocks instead of cidr_ipv4
  from_port          = var.security_group_info.inbound_rules[count.index].from_port
  to_port            = var.security_group_info.inbound_rules[count.index].to_port
  protocol           = var.security_group_info.inbound_rules[count.index].ip_protocol // Use protocol instead of ip_protocol
  description        = var.security_group_info.inbound_rules[count.index].description

  depends_on = [aws_security_group.sg]
}


# outbound rules
resource "aws_security_group_rule" "sg_out" {
  count = length(var.security_group_info.outbound_rules) 
  security_group_id = aws_security_group.sg.id
  type = var.security_group_info.outbound_rules[count.index].type
  cidr_blocks = [var.security_group_info.outbound_rules[count.index].cidr_blocks]
  from_port = var.security_group_info.outbound_rules[count.index].from_port
  to_port = var.security_group_info.outbound_rules[count.index].to_port
  protocol = var.security_group_info.outbound_rules[count.index].ip_protocol
  description = var.security_group_info.outbound_rules[count.index].description
  
  depends_on = [ aws_security_group.sg ]
}

