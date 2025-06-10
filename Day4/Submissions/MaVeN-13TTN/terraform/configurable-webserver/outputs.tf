# Day 4 - Configurable Web Server Outputs
# Output values to display information about the deployed infrastructure

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.configurable_web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.configurable_web_server.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.configurable_web_server.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.configurable_web_server.public_dns
}

output "elastic_ip" {
  description = "Elastic IP address (if allocated)"
  value       = var.allocate_eip ? aws_eip.web_server_eip[0].public_ip : null
}

output "website_url" {
  description = "URL to access the website"
  value       = var.server_port == 80 ? "http://${aws_instance.configurable_web_server.public_ip}" : "http://${aws_instance.configurable_web_server.public_ip}:${var.server_port}"
}

output "website_url_dns" {
  description = "URL to access the website using DNS name"
  value       = var.server_port == 80 ? "http://${aws_instance.configurable_web_server.public_dns}" : "http://${aws_instance.configurable_web_server.public_dns}:${var.server_port}"
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.configurable_web_sg.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.configurable_web_sg.name
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = var.enable_ssh && var.create_key_pair ? aws_key_pair.web_server_key[0].key_name : var.existing_key_name
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.configurable_web_server.instance_state
}

output "instance_type" {
  description = "Type of the EC2 instance"
  value       = aws_instance.configurable_web_server.instance_type
}

output "ami_id" {
  description = "AMI ID used for the instance"
  value       = aws_instance.configurable_web_server.ami
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = data.aws_vpc.default.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = data.aws_subnet.default.id
}

output "availability_zone" {
  description = "Availability zone of the instance"
  value       = aws_instance.configurable_web_server.availability_zone
}

# Configuration Summary
output "configuration_summary" {
  description = "Summary of the server configuration"
  value = {
    server_name   = var.server_name
    environment   = var.environment
    instance_type = var.instance_type
    server_port   = var.server_port
    ssh_enabled   = var.enable_ssh
    https_enabled = var.enable_https
    eip_allocated = var.allocate_eip
    encryption    = var.enable_encryption
    monitoring    = var.enable_detailed_monitoring
  }
}

# SSH Connection Command
output "ssh_connection" {
  description = "SSH command to connect to the instance"
  value       = var.enable_ssh ? "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.configurable_web_server.public_ip}" : "SSH is disabled for this instance"
  sensitive   = false
}
