# Variables for Clustered Web Server Configuration

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "terraform-challenge"
}

variable "server_port" {
  description = "Port number for the web server"
  type        = number
  default     = 80

  validation {
    condition     = var.server_port > 0 && var.server_port <= 65535
    error_message = "Server port must be between 1 and 65535."
  }
}

variable "instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t3.micro"

  validation {
    condition = contains([
      "t2.micro", "t2.small", "t2.medium",
      "t3.micro", "t3.small", "t3.medium",
      "t3a.micro", "t3a.small", "t3a.medium"
    ], var.instance_type)
    error_message = "Instance type must be a valid AWS instance type."
  }
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 2

  validation {
    condition     = var.min_size >= 1 && var.min_size <= 10
    error_message = "Minimum size must be between 1 and 10."
  }
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 6

  validation {
    condition     = var.max_size >= 1 && var.max_size <= 20
    error_message = "Maximum size must be between 1 and 20."
  }
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 3

  validation {
    condition     = var.desired_capacity >= 1 && var.desired_capacity <= 10
    error_message = "Desired capacity must be between 1 and 10."
  }
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring for instances"
  type        = bool
  default     = false
}

variable "health_check_type" {
  description = "Type of health check for Auto Scaling Group"
  type        = string
  default     = "ELB"

  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "Health check type must be either EC2 or ELB."
  }
}

variable "health_check_grace_period" {
  description = "Grace period for health checks (seconds)"
  type        = number
  default     = 300

  validation {
    condition     = var.health_check_grace_period >= 60 && var.health_check_grace_period <= 3600
    error_message = "Health check grace period must be between 60 and 3600 seconds."
  }
}

variable "load_balancer_type" {
  description = "Type of load balancer (application or network)"
  type        = string
  default     = "application"

  validation {
    condition     = contains(["application", "network"], var.load_balancer_type)
    error_message = "Load balancer type must be either application or network."
  }
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "target_group_health_check_path" {
  description = "Health check path for target group"
  type        = string
  default     = "/"
}

variable "target_group_health_check_interval" {
  description = "Health check interval for target group (seconds)"
  type        = number
  default     = 30

  validation {
    condition     = var.target_group_health_check_interval >= 5 && var.target_group_health_check_interval <= 300
    error_message = "Health check interval must be between 5 and 300 seconds."
  }
}

variable "target_group_health_check_timeout" {
  description = "Health check timeout for target group (seconds)"
  type        = number
  default     = 5

  validation {
    condition     = var.target_group_health_check_timeout >= 2 && var.target_group_health_check_timeout <= 120
    error_message = "Health check timeout must be between 2 and 120 seconds."
  }
}

variable "target_group_healthy_threshold" {
  description = "Number of consecutive successful health checks required"
  type        = number
  default     = 2

  validation {
    condition     = var.target_group_healthy_threshold >= 2 && var.target_group_healthy_threshold <= 10
    error_message = "Healthy threshold must be between 2 and 10."
  }
}

variable "target_group_unhealthy_threshold" {
  description = "Number of consecutive failed health checks required"
  type        = number
  default     = 3

  validation {
    condition     = var.target_group_unhealthy_threshold >= 2 && var.target_group_unhealthy_threshold <= 10
    error_message = "Unhealthy threshold must be between 2 and 10."
  }
}

variable "enable_autoscaling_policies" {
  description = "Enable Auto Scaling policies for CPU-based scaling"
  type        = bool
  default     = true
}

variable "scale_up_cpu_threshold" {
  description = "CPU utilization threshold for scaling up"
  type        = number
  default     = 70

  validation {
    condition     = var.scale_up_cpu_threshold >= 10 && var.scale_up_cpu_threshold <= 100
    error_message = "Scale up CPU threshold must be between 10 and 100."
  }
}

variable "scale_down_cpu_threshold" {
  description = "CPU utilization threshold for scaling down"
  type        = number
  default     = 30

  validation {
    condition     = var.scale_down_cpu_threshold >= 10 && var.scale_down_cpu_threshold <= 100
    error_message = "Scale down CPU threshold must be between 10 and 100."
  }
}

variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "key_pair_name" {
  description = "Name of the EC2 Key Pair for SSH access (optional)"
  type        = string
  default     = ""
}

variable "enable_ssh_access" {
  description = "Enable SSH access to instances"
  type        = bool
  default     = false
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "application_name" {
  description = "Name of the application for display"
  type        = string
  default     = "Terraform Challenge - Clustered Web Server"
}

variable "application_version" {
  description = "Version of the application"
  type        = string
  default     = "1.0.0"
}

variable "enable_https" {
  description = "Enable HTTPS listener on load balancer"
  type        = bool
  default     = false
}

variable "ssl_certificate_arn" {
  description = "ARN of SSL certificate for HTTPS (required if enable_https is true)"
  type        = string
  default     = ""
}
