output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
  ]
}

output "public_subnet_id_1" {
  description = "ID of the first public subnet"
  value       = aws_subnet.public_1.id
}

output "public_subnet_id_2" {
  description = "ID of the second public subnet"
  value       = aws_subnet.public_2.id
}

output "igw_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.this.id
}

output "route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}
