output "apacheurl" {
  value = "http://${aws_instance.apache2.public_ip}"
}

output "nginxurl" {
  value = "http://${aws_instance.nginx.public_ip}"
}

output "tomcat9url" {
  value = "http://${aws_instance.tomcat9.public_ip}:8080"
}