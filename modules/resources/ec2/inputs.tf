variable "ec2_info" {
  type = object({
  name = string
  ami = string
  instance_type = string
  key_name = string
  subnet_id = string
  associate_public_ip_address = boolean
  })
}