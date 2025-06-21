output "primary_instance_id" {
  value = module.compute_primary.instance_id
}

output "primary_instance_ip" {
  value = module.compute_primary.public_ip
}

output "secondary_instance_id" {
  value = module.compute_secondary.instance_id
}

output "secondary_instance_ip" {
  value = module.compute_secondary.public_ip
}
