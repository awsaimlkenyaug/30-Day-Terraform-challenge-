output "alb_dns" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}
output "instance_type" {
  value = var.instance_type
}
