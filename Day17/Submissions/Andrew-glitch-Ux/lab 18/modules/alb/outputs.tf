output "alb_dns_name" {
  value = aws_lb.this.dns_name  
}


output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}
