resource "aws_security_group" "application-sg" {
  name        = var.application_sg_config.name
  description = var.application_sg_config.description
  vpc_id      = local.vpc_id
  depends_on  = [aws_vpc.ntier-vpc]
}
resource "aws_security_group_rule" "application-sg-rules" {
  count             = length("${var.application_sg_config.rules}")
  security_group_id = aws_security_group.application-sg.id
  type              = "${var.application_sg_config.rules}" [count.index].type
  from_port         = "${var.application_sg_config.rules}" [count.index].from_port
  to_port           = "${var.application_sg_config.rules}" [count.index].to_port
  protocol          = "${var.application_sg_config.rules}" [count.index].protocol
  cidr_blocks       = ["${var.application_sg_config.rules}" [count.index].cidr_block]
  depends_on        = [aws_security_group.application-sg]
} 