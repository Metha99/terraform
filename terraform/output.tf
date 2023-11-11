output "public_ip_of_demo_server" {
  description = "this is the public IP"
  value = aws_instance.metha-server.public_ip
}

output "private_ip_of_demo_server" {
  description = "this is the public IP"
  value = aws_instance.metha-server.private_ip
}
