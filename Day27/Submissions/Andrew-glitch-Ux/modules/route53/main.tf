resource "aws_route53_zone" "this" {
  name = var.zone_name  # e.g., example.com

  tags = merge(
    var.common_tags,
    {
      Name = var.zone_name
    }
  )
}

# Record for ALB
resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.record_name_alb            # e.g., "app"
  type    = var.record_type_alb            # "A" or "CNAME"
  ttl     = var.ttl
  records = [var.record_value_alb]         # module.elb.alb_dns_name

  # 💡 Typically: A CNAME pointing to ALB's DNS
}

# Record for EC2
resource "aws_route53_record" "ec2_record" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.record_name_ec2            # e.g., "ec2"
  type    = var.record_type_ec2            # "A"
  ttl     = var.ttl
  records = [var.record_value_ec2]         # module.ec2.public_ip
}


