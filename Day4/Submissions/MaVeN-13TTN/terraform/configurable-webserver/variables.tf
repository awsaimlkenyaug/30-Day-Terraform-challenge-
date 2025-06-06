# Day 4 - Configurable Web Server Variables
# Input variables to make the infrastructure configurable

# AWS Configuration
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "AWS region must be in the format like 'us-east-1'."
  }
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}

# Project Information
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "30-day-terraform-challenge"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "learning"

  validation {
    condition     = contains(["dev", "staging", "prod", "learning"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, learning."
  }
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "MaVeN-13TTN"
}

# Server Configuration
variable "server_name" {
  description = "Name of the web server"
  type        = string
  default     = "configurable-web-server"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.server_name))
    error_message = "Server name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "t2.micro", "t2.small"], var.instance_type)
    error_message = "Instance type must be a valid EC2 instance type."
  }
}

variable "server_port" {
  description = "Port number for the web server"
  type        = number
  default     = 80

  validation {
    condition     = var.server_port >= 1 && var.server_port <= 65535
    error_message = "Server port must be between 1 and 65535."
  }
}

# Security Configuration
variable "enable_ssh" {
  description = "Enable SSH access to the server"
  type        = bool
  default     = true
}

variable "enable_https" {
  description = "Enable HTTPS access (port 443)"
  type        = bool
  default     = false
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Note: In production, restrict this!

  validation {
    condition     = length(var.ssh_cidr_blocks) > 0
    error_message = "At least one CIDR block must be specified for SSH access."
  }
}

variable "http_cidr_blocks" {
  description = "CIDR blocks allowed for HTTP/HTTPS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Key Pair Configuration
variable "create_key_pair" {
  description = "Whether to create a new key pair"
  type        = bool
  default     = true
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC... # Replace with your actual public key"
}

variable "existing_key_name" {
  description = "Name of existing key pair to use (if create_key_pair is false)"
  type        = string
  default     = null
}

# Storage Configuration
variable "root_volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp3", "gp2", "io1", "io2"], var.root_volume_type)
    error_message = "Root volume type must be one of: gp3, gp2, io1, io2."
  }
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 8

  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 100
    error_message = "Root volume size must be between 8 and 100 GB."
  }
}

variable "enable_encryption" {
  description = "Enable EBS encryption"
  type        = bool
  default     = true
}

# Performance Configuration
variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = false
}

variable "enable_ebs_optimization" {
  description = "Enable EBS optimization"
  type        = bool
  default     = true
}

# Network Configuration
variable "allocate_eip" {
  description = "Allocate Elastic IP for the instance"
  type        = bool
  default     = false
}

# Content Configuration
variable "custom_html_content" {
  description = "Custom HTML content to display on the web page"
  type        = string
  default     = ""
}
