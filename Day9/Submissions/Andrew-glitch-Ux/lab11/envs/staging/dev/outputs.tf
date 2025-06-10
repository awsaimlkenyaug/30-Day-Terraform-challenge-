output "instance_public_ip" {
  value = module.web_server.instance_public_ip
}

output "vpc_id" {
  value = module.web_server.vpc_id
}

output "subnet_id" {
  value = module.web_server.subnet_id
}
