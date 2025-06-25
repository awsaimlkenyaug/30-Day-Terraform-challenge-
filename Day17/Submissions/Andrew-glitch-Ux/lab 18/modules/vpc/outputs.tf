output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "internet_gateway_id" {
  description = "ID of the created Internet Gateway"
  value       = aws_internet_gateway.this.id
}
