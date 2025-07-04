output "vpc_id" {
  description = "ID of the VPC"
  value       = "test-mode-vpc-id"
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = ["test-mode-subnet-id"]
}

output "web_security_group_id" {
  description = "ID of the web security group"
  value       = "test-mode-sg-id"
}

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = "test-mode-alb-sg-id"
}