# output the public IP address of the EC2 instance
output "web-address" {
  value = aws_instance.server.public_ip
}
