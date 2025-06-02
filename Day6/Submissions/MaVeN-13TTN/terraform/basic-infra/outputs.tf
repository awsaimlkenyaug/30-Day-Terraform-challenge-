output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.main.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web.id
}

output "vpc_details" {
  description = "Comprehensive details about the VPC"
  value = {
    id                  = aws_vpc.main.id
    cidr_block          = aws_vpc.main.cidr_block
    enable_dns_support  = aws_vpc.main.enable_dns_support
    enable_dns_hostnames = aws_vpc.main.enable_dns_hostnames
    tags                = aws_vpc.main.tags
  }
}