## create EC2 instance
resource "aws_instance""application" {
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
## Null Resource
resource "null_resource" "ubuntu-server-application" {
  connection {
    type = "ssh"
    user = "ubuntu"
    password = "rootroot"
    agent = false
    host = "${aws_instance.application.public_ip}"
    private_key = "${file(var.application-network-info.private_key_path)}"

  }

  
provisioner "file" {
  source = "./nginx.yaml"
  destination = "/home/ubuntu/nginx.yaml"
}
provisioner "file" {
  source = "./apache2.sh"
  destination = "/home/ubuntu/tomcat9.yaml"
}

provisioner "file" {
 source = "C:/Users/batchu sivaji/.ssh/id_rsa"
 destination = "/home/ubuntu/id_rsa"
}
#provisioner "file" {
#  source = "C:/Users/batchu sivaji/Downloads/spring-petclinic-2.4.2.jar"
#  destination = "/home/ubuntu/spring-petclinic-2.4.2.jar"
#}
# provisioner "local-exec" {
#  command = " echo ${aws_instance.application.private_ip} >> ip.txt "
# }

provisioner "file" {
 source = "./inventory"
 destination = "/home/ubuntu/inventory"
}

 provisioner "remote-exec" {
  inline = [ 
"sudo apt update", 
"sudo apt-add-repository ppa:ansible/ansible -y",
"sudo apt install ansible -y" ,
"chmod +x /home/ubuntu/tomcat9.yaml", 
"echo '''ubuntu@localhost''' > inventory" ,
"chmod 400 /home/ubuntu/id_rsa",
"chmod 400 /home/ubuntu/dependency.sh",
"ssh-keyscan -H localhost >> ~/.ssh/known_hosts",
"ansible -i inventory -m ping all --private-key /home/ubuntu/id_rsa",
#export ANSIBLE_SSH_ARGS="-o UserKnownHostsFile=/dev/null -o king=no" ansible -i inventory -m ping all --private-key /home/ubuntu/id_rsa ,
#"ansible-playbook -i inventory tomcat9.yaml"
"ansible-playbook -i inventory nginx.yaml"
  ]  

 }
triggers = {
   version = var.application-network-info.version
 }
}
   
