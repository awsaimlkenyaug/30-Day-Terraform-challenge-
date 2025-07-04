output "network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint for the GKE cluster"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  description = "The public certificate authority of the GKE cluster"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}