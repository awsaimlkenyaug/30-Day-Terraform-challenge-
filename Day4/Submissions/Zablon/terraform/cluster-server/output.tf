output "alb_dns_name" {
  value       = aws_lb.load_balancer.dns_name
  description = "domain name of the load balancer"
}
