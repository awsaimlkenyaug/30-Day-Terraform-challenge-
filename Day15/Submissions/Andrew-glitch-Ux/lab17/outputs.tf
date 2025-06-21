output "aws_vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.aws_vpc.id
}

output "aws_subnet_a_id" {
  description = "Subnet A ID"
  value       = aws_subnet.subnet_a.id
}

output "aws_subnet_b_id" {
  description = "Subnet B ID"
  value       = aws_subnet.subnet_b.id
}

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.cluster.name
}

# Optional GCP placeholders if needed:
# output "gcp_vpc_name" {
#   description = "GCP VPC name"
#   value       = var.gcp_vpc_name
# }

# output "gcp_subnet_name" {
#   description = "GCP Subnet name"
#   value       = var.gcp_subnet_name
# }



