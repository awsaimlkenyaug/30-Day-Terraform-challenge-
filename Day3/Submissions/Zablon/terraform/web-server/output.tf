# output the ami ID used by the EC2 instance
output "ami" {
  value = aws_instance.webserver.ami
}

# output the public IP address of the EC2 instance
output "web-address" {
  value = aws_instance.webserver.public_ip
}
