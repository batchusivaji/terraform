## create EC2 instance
resource "aws_instance" "application" {
  instance_type               = var.application-network-info.instance_size
  associate_public_ip_address = "true"
  ami                         = var.application-network-info.ami_id
  subnet_id                   = aws_subnet.ntier-subnets[0].id
  vpc_security_group_ids      = [aws_security_group.application-sg.id]
  key_name                    = aws_key_pair.public-key.key_name
  tags = {
    Name = "compute-engine"
  }
  depends_on = [
    aws_security_group.application-sg
  ]
}


resource "null_resource" "null" {
  connection {
    type = "ssh"
    user = "ubuntu"
    agent = false
    host = "${aws_instance.application.public_ip}"
    private_key = "${file(var.application-network-info.private_key_path)}"
  }

  provisioner "file" {
    source = "./spring-petclinic-3.0.0-20230816.075709-9.jar"
    destination = "/home/ubuntu/spring-petclinic-3.0.0-20230816.075709-9.jar"
  }
  provisioner "file" {
     source = "./tomcat10.service"
     destination = "/home/ubuntu/tomcat10.service"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.application.id} >> compute.txt"
  } 
  triggers = {
    vsersion = 2
  }
}
