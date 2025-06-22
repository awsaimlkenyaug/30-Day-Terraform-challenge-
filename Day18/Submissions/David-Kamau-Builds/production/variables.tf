variable "deployment_mode" {
  description = "Controls whether resources are actually deployed. Set to 'test' to prevent resource creation and costs"
  type        = string
  default     = "test"
  validation {
    condition     = contains(["test", "deploy"], var.deployment_mode)
    error_message = "deployment_mode must be either 'test' or 'deploy'"
  }
}

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
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "instance_count" {
  description = "Number of instances to launch in the active environment"
  type        = number
  default     = 2
  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 5
    error_message = "instance_count must be between 1 and 5"
  }
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

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "dbadmin"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8
    error_message = "Database password must be at least 8 characters long"
  }
}

variable "api_key" {
  description = "API key for external service"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "Secret for JWT token signing"
  type        = string
  sensitive   = true
}

# GCP Variables
variable "gcp_project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "gcp_node_count" {
  description = "Number of GKE nodes to provision"
  type        = number
  default     = 2
  validation {
    condition     = var.gcp_node_count > 0 && var.gcp_node_count <= 5
    error_message = "gcp_node_count must be between 1 and 5"
  }
}

# VPC Module Required Variables
variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the web and ALB resources"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_arn_east" {
  description = "ARN of the Application Load Balancer for WAF association in us-east-1"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/test/test"
}

variable "alb_arn_west" {
  description = "ARN of the Application Load Balancer for WAF association in us-west-2"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/test/test"
}

variable "waf_web_acl_arn_east" {
  description = "ARN of the WAF Web ACL to associate with the ALB in us-east-1"
  type        = string
  default     = "arn:aws:wafv2:us-east-1:123456789012:global/webacl/test/test"
}

variable "waf_web_acl_arn_west" {
  description = "ARN of the WAF Web ACL to associate with the ALB in us-west-2"
  type        = string
  default     = "arn:aws:wafv2:us-west-2:123456789012:global/webacl/test/test"
}