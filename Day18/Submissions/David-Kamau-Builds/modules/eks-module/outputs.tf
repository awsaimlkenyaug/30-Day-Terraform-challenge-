output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = "test-mode-eks-cluster"
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = "https://test-mode-eks-endpoint.eks.amazonaws.com"
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = "test-mode-eks-sg-id"
}

output "cluster_iam_role_name" {
  description = "IAM role name associated with EKS cluster"
  value       = "test-mode-eks-role"
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = "dGVzdC1tb2RlLWNlcnRpZmljYXRlLWRhdGE="
}

output "node_group_id" {
  description = "EKS node group ID"
  value       = "test-mode-node-group-id"
}