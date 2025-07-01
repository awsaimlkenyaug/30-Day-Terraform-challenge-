output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}


output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id_1" {
  value = module.vpc.public_subnet_id_1
}



output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = module.elb.target_group_arn
}
