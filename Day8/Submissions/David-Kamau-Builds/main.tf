module "web_server" {
  source             = "./modules/ec2-module"
  instance_name      = var.instance_name
  environment        = var.environment
  instance_type      = var.instance_type
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  key_name           = var.key_name
}

output "web_server_id" {
  description = "EC2 instance ID"
  value       = module.web_server.instance_id
}

output "web_server_public_ip" {
  description = "Public IP of the web server"
  value       = module.web_server.public_ip
}
