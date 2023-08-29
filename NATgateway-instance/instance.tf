### create EC2 instance
#resource "aws_instance""application" {
#  instance_type               = var.application-network-info.instance_size
#  associate_public_ip_address = "true"
#  ami                         = var.application-network-info.ami_id
#  subnet_id                   = aws_subnet.ntier-subnets[1].id
#  vpc_security_group_ids      = [aws_security_group.application-sg.id]
#  key_name                    = aws_key_pair.public-key.key_name
#  tags = {
#    Name = "compute-engine"
#  }
#  depends_on = [
#    aws_security_group.application-sg
#  ]
#}