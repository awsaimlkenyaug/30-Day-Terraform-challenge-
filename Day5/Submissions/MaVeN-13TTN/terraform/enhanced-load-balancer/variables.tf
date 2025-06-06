# Enhanced Load Balancer Variables
# Day 5: Scaling Infrastructure & State Management

# Basic Configuration
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "learning"

  validation {
    condition = contains([
      "dev", "staging", "prod", "learning", "test"
    ], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, learning, test."
  }
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]
}

# Instance Configuration
variable "instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t3.micro"

  validation {
    condition = contains([
      "t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge",
      "t2.micro", "t2.small", "t2.medium", "t2.large"
    ], var.instance_type)
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
}

variable "key_name" {
  description = "Name of the AWS key pair for EC2 instances"
  type        = string
  default     = ""
}

variable "server_port" {
  description = "The port the web server will listen on"
  type        = number
  default     = 80

  validation {
    condition     = var.server_port > 0 && var.server_port < 65536
    error_message = "Server port must be between 1 and 65535."
  }
}

variable "server_text" {
  description = "Text to display on the web server"
  type        = string
  default     = "Hello, World from Day 5 Enhanced Load Balancer!"
}

# Auto Scaling Configuration
variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 2

  validation {
    condition     = var.min_size >= 1 && var.min_size <= 10
    error_message = "Minimum size must be between 1 and 10."
  }
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 6

  validation {
    condition     = var.max_size >= 1 && var.max_size <= 20
    error_message = "Maximum size must be between 1 and 20."
  }
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 3

  validation {
    condition     = var.desired_capacity >= 1
    error_message = "Desired capacity must be at least 1."
  }
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300

  validation {
    condition     = var.health_check_grace_period >= 0
    error_message = "Health check grace period must be non-negative."
  }
}

variable "termination_policies" {
  description = "List of policies to use for instance termination"
  type        = list(string)
  default     = ["OldestInstance", "Default"]

  validation {
    condition = alltrue([
      for policy in var.termination_policies :
      contains([
        "OldestInstance", "NewestInstance", "OldestLaunchConfiguration",
        "ClosestToNextInstanceHour", "OldestLaunchTemplate", "AllocationStrategy", "Default"
      ], policy)
    ])
    error_message = "All termination policies must be valid AWS Auto Scaling termination policies."
  }
}

# Target Tracking Scaling Configuration
variable "cpu_target_percentage" {
  description = "Target CPU utilization percentage for auto scaling"
  type        = number
  default     = 70

  validation {
    condition     = var.cpu_target_percentage > 0 && var.cpu_target_percentage <= 100
    error_message = "CPU target percentage must be between 1 and 100."
  }
}

variable "scale_out_cooldown" {
  description = "Cooldown period (seconds) for scale out operations"
  type        = number
  default     = 300

  validation {
    condition     = var.scale_out_cooldown >= 0
    error_message = "Scale out cooldown must be non-negative."
  }
}

variable "scale_in_cooldown" {
  description = "Cooldown period (seconds) for scale in operations"
  type        = number
  default     = 300

  validation {
    condition     = var.scale_in_cooldown >= 0
    error_message = "Scale in cooldown must be non-negative."
  }
}

# Step Scaling Configuration
variable "high_cpu_threshold" {
  description = "High CPU threshold for step scaling alarm"
  type        = number
  default     = 85

  validation {
    condition     = var.high_cpu_threshold > 0 && var.high_cpu_threshold <= 100
    error_message = "High CPU threshold must be between 1 and 100."
  }
}

variable "low_cpu_threshold" {
  description = "Low CPU threshold for step scaling alarm"
  type        = number
  default     = 25

  validation {
    condition     = var.low_cpu_threshold >= 0 && var.low_cpu_threshold < 100
    error_message = "Low CPU threshold must be between 0 and 99."
  }
}

variable "scale_up_adjustment" {
  description = "Number of instances to add during scale up"
  type        = number
  default     = 2

  validation {
    condition     = var.scale_up_adjustment > 0
    error_message = "Scale up adjustment must be positive."
  }
}

variable "scale_down_adjustment" {
  description = "Number of instances to remove during scale down (negative value)"
  type        = number
  default     = -1

  validation {
    condition     = var.scale_down_adjustment < 0
    error_message = "Scale down adjustment must be negative."
  }
}

variable "scale_up_cooldown" {
  description = "Cooldown period (seconds) after scale up"
  type        = number
  default     = 300
}

variable "scale_down_cooldown" {
  description = "Cooldown period (seconds) after scale down"
  type        = number
  default     = 600
}

# CloudWatch Configuration
variable "high_cpu_evaluation_periods" {
  description = "Number of periods to evaluate for high CPU alarm"
  type        = number
  default     = 2

  validation {
    condition     = var.high_cpu_evaluation_periods > 0
    error_message = "Evaluation periods must be positive."
  }
}

variable "low_cpu_evaluation_periods" {
  description = "Number of periods to evaluate for low CPU alarm"
  type        = number
  default     = 3

  validation {
    condition     = var.low_cpu_evaluation_periods > 0
    error_message = "Evaluation periods must be positive."
  }
}

variable "cloudwatch_alarm_period" {
  description = "Period (seconds) for CloudWatch alarms"
  type        = number
  default     = 120

  validation {
    condition     = contains([60, 120, 300, 600, 900, 1800, 3600], var.cloudwatch_alarm_period)
    error_message = "CloudWatch alarm period must be one of: 60, 120, 300, 600, 900, 1800, 3600 seconds."
  }
}

# Health Check Configuration
variable "health_check_healthy_threshold" {
  description = "Number of consecutive health checks successes required"
  type        = number
  default     = 2

  validation {
    condition     = var.health_check_healthy_threshold >= 2 && var.health_check_healthy_threshold <= 10
    error_message = "Healthy threshold must be between 2 and 10."
  }
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures required"
  type        = number
  default     = 3

  validation {
    condition     = var.health_check_unhealthy_threshold >= 2 && var.health_check_unhealthy_threshold <= 10
    error_message = "Unhealthy threshold must be between 2 and 10."
  }
}

variable "health_check_timeout" {
  description = "Health check timeout (seconds)"
  type        = number
  default     = 5

  validation {
    condition     = var.health_check_timeout >= 2 && var.health_check_timeout <= 120
    error_message = "Health check timeout must be between 2 and 120 seconds."
  }
}

variable "health_check_interval" {
  description = "Health check interval (seconds)"
  type        = number
  default     = 30

  validation {
    condition     = var.health_check_interval >= 5 && var.health_check_interval <= 300
    error_message = "Health check interval must be between 5 and 300 seconds."
  }
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"

  validation {
    condition     = can(regex("^/", var.health_check_path))
    error_message = "Health check path must start with '/'."
  }
}

variable "health_check_matcher" {
  description = "Health check response code matcher"
  type        = string
  default     = "200"

  validation {
    condition     = can(regex("^[0-9,-]+$", var.health_check_matcher))
    error_message = "Health check matcher must be valid HTTP response codes (e.g., '200' or '200-299')."
  }
}

# Security Configuration
variable "enable_http" {
  description = "Enable HTTP access on ALB"
  type        = bool
  default     = true
}

variable "enable_https" {
  description = "Enable HTTPS access on ALB"
  type        = bool
  default     = false
}

variable "redirect_http_to_https" {
  description = "Redirect HTTP traffic to HTTPS"
  type        = bool
  default     = false
}

variable "ssl_policy" {
  description = "SSL policy for HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"

  validation {
    condition = contains([
      "ELBSecurityPolicy-TLS-1-2-2017-01",
      "ELBSecurityPolicy-TLS-1-2-Ext-2018-06",
      "ELBSecurityPolicy-FS-2018-06",
      "ELBSecurityPolicy-FS-1-2-2019-08",
      "ELBSecurityPolicy-FS-1-2-Res-2019-08",
      "ELBSecurityPolicy-FS-1-2-Res-2020-10"
    ], var.ssl_policy)
    error_message = "SSL policy must be a valid ELB security policy."
  }
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS"
  type        = string
  default     = ""
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the load balancer"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition = alltrue([
      for cidr in var.allowed_cidr_blocks :
      can(cidrhost(cidr, 0))
    ])
    error_message = "All allowed CIDR blocks must be valid CIDR notation."
  }
}

variable "enable_ssh" {
  description = "Enable SSH access to instances"
  type        = bool
  default     = false
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition = alltrue([
      for cidr in var.ssh_cidr_blocks :
      can(cidrhost(cidr, 0))
    ])
    error_message = "All SSH CIDR blocks must be valid CIDR notation."
  }
}

# Monitoring Configuration
variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring for instances"
  type        = bool
  default     = true
}

# EBS Configuration
variable "ebs_volume_type" {
  description = "EBS volume type for instances"
  type        = string
  default     = "gp3"

  validation {
    condition = contains([
      "gp2", "gp3", "io1", "io2", "st1", "sc1"
    ], var.ebs_volume_type)
    error_message = "EBS volume type must be one of: gp2, gp3, io1, io2, st1, sc1."
  }
}

variable "ebs_volume_size" {
  description = "EBS volume size in GB"
  type        = number
  default     = 8

  validation {
    condition     = var.ebs_volume_size >= 1 && var.ebs_volume_size <= 16384
    error_message = "EBS volume size must be between 1 and 16384 GB."
  }
}

variable "enable_ebs_encryption" {
  description = "Enable EBS volume encryption"
  type        = bool
  default     = true
}

# ALB Configuration
variable "enable_deletion_protection" {
  description = "Enable deletion protection for ALB"
  type        = bool
  default     = false
}

variable "enable_access_logs" {
  description = "Enable ALB access logs"
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "S3 bucket for ALB access logs"
  type        = string
  default     = ""
}

variable "access_logs_prefix" {
  description = "S3 prefix for ALB access logs"
  type        = string
  default     = "alb-logs"
}

# Stickiness Configuration
variable "enable_stickiness" {
  description = "Enable session stickiness"
  type        = bool
  default     = false
}

variable "stickiness_duration" {
  description = "Stickiness duration in seconds"
  type        = number
  default     = 86400

  validation {
    condition     = var.stickiness_duration >= 1 && var.stickiness_duration <= 604800
    error_message = "Stickiness duration must be between 1 second and 7 days (604800 seconds)."
  }
}
