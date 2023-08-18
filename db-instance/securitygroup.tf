
resource "aws_security_group" "dbsg" {
  name        = var.db_sg_config.name
  description = var.db_sg_config.description
  vpc_id      = aws_vpc.ntier_vpc.id

  depends_on = [
    aws_vpc.ntier_vpc
  ]

}

resource "aws_security_group_rule" "dbsg_rules" {
  count             = length(var.db_sg_config.rules)
  security_group_id = aws_security_group.dbsg.id
  type              = var.db_sg_config.rules[count.index].type
  from_port         = var.db_sg_config.rules[count.index].from_port
  to_port           = var.db_sg_config.rules[count.index].to_port
  protocol          = var.db_sg_config.rules[count.index].protocol
  cidr_blocks       = [var.db_sg_config.rules[count.index].cidr_block]
  depends_on = [
    aws_security_group.dbsg
  ]
}



