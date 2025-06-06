output "load_balancer_id" {
  description = "ID of the load balancer"
  value       = aws_lb.main.id
}

output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "Canonical hosted zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "load_balancer_url" {
  description = "URL of the load balancer"
  value       = "${var.listener_protocol == "HTTPS" ? "https" : "http"}://${aws_lb.main.dns_name}"
}

output "target_group_id" {
  description = "ID of the target group"
  value       = aws_lb_target_group.main.id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.main.name
}

output "listener_id" {
  description = "ID of the listener"
  value       = aws_lb_listener.main.id
}

output "listener_arn" {
  description = "ARN of the listener"
  value       = aws_lb_listener.main.arn
}
