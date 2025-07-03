
output "web_server_instance_id" {
  value       = var.deploy_web_server ? module.web_server[0].instance_id : null
  description = "ID of the EC2 instance"
}
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC created"
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "ID of the public subnet"
}


output "web_server_public_ip" {
  value       = var.deploy_web_server ? module.web_server[0].public_ip : ""
  description = "Public IP of the EC2 instance"
}
