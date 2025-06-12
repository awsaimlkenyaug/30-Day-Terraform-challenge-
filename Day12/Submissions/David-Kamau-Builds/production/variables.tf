variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "dkb-web"
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
  default     = "prod"
  validation {
    condition     = contains(["dev","staging","prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "admin_cidr" {
  description = "CIDR block for admin access"
  type        = string
  default     = "0.0.0.0/0"  # In production, restrict to your IP
}

variable "ssh_key_name" {
  description = "Name of EC2 key pair for SSH access"
  type        = string
  default     = "my-key-pair"  # Replace with your key pair name
}

variable "instance_count" {
  description = "Number of instances to launch in the active environment"
  type        = number
  default     = 2
}

variable "active_deployment" {
  description = "Which deployment is currently active: blue or green"
  type        = string
  default     = "blue"
  validation {
    condition     = contains(["blue", "green"], var.active_deployment)
    error_message = "active_deployment must be either 'blue' or 'green'"
  }
}

variable "blue_version" {
  description = "Version tag for blue environment"
  type        = string
  default     = "1.0.0"
}

variable "green_version" {
  description = "Version tag for green environment"
  type        = string
  default     = "1.0.1"
}