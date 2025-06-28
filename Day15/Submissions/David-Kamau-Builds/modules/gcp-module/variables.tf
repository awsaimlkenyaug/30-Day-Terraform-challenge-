variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR for the subnet"
  type        = string
  default     = "10.10.0.0/16"
}

variable "pods_cidr" {
  description = "CIDR for Kubernetes pods"
  type        = string
  default     = "10.20.0.0/16"
}

variable "services_cidr" {
  description = "CIDR for Kubernetes services"
  type        = string
  default     = "10.30.0.0/16"
}

variable "node_count" {
  description = "Number of GKE nodes"
  type        = number
  default     = 2
}