output "hosted_zone_id" {
  description = "ID of the Route53 hosted zone"
  value       = aws_route53_zone.this.zone_id
}

output "hosted_zone_name" {
  description = "Name of the Route53 hosted zone (e.g., example.com)"
  value       = aws_route53_zone.this.name
}

# Output for ALB DNS Record
output "alb_record_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) for the ALB"
  value       = "${aws_route53_record.alb_record.name}.${aws_route53_zone.this.name}"
}

# Output for EC2 DNS Record
output "ec2_record_fqdn" {
  description = "FQDN for the EC2 instance"
  value       = "${aws_route53_record.ec2_record.name}.${aws_route53_zone.this.name}"
}

