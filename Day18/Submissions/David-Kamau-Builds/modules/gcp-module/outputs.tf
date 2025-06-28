output "network_name" {
  description = "The name of the VPC network"
  value       = "test-mode-gcp-network"
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = "test-mode-gcp-subnet"
}

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = "test-mode-gke-cluster"
}

output "cluster_endpoint" {
  description = "The endpoint for the GKE cluster"
  value       = "https://test-mode-gke-endpoint.googleapis.com"
}

output "cluster_ca_certificate" {
  description = "The public certificate authority of the GKE cluster"
  value       = "dGVzdC1tb2RlLWNlcnRpZmljYXRlLWRhdGE="
  sensitive   = true
}