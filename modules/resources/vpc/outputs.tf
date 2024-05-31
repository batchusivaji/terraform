output "vpc_id" {
  value = aws_vpc.network.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_subnets" {
    value = aws_subnet.private.*.id
}