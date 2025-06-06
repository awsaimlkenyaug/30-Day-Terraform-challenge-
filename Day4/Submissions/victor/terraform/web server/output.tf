output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "instance_public_ips" {
  description = "Public IP addresses of the web servers"
  value       = aws_instance.web_server[*].public_ip
}