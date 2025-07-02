variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type per environment"
  type        = map(string)
  default = {
    dev        = "t3.micro"
    staging    = "t3.small"
    production = "t3.medium"
  }
}

variable "min_size" {
  description = "Minimum number of instances per environment"
  type        = map(number)
  default = {
    dev        = 1
    staging    = 2
    production = 3
  }
}

variable "max_size" {
  description = "Maximum number of instances per environment"
  type        = map(number)
  default = {
    dev        = 2
    staging    = 4
    production = 6
  }
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

# New variables for conditional deployments
variable "force_alb_in_dev" {
  description = "Force ALB deployment in dev environment"
  type        = bool
  default     = false
}

variable "enable_enhanced_monitoring" {
  description = "Enable enhanced monitoring for EC2 instances"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = map(number)
  default = {
    dev        = 1
    staging    = 7
    production = 30
  }
}

# Sensitive variables for secrets management
variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "API key for external services"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret"
  type        = string
  sensitive   = true
}