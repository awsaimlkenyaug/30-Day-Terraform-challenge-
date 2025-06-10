variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-file-layout-isolation"
}

variable "application_name" {
  description = "Name of the application"
  type        = string
  default     = "web-app"
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
  default     = null
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true # Enabled for staging to test production-like setup
}

variable "create_database_sg" {
  description = "Create database security group"
  type        = bool
  default     = true # Enabled for staging environment
}

variable "access_logs_bucket" {
  description = "S3 bucket for ALB access logs"
  type        = string
  default     = null
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    Project     = "30-Day-Terraform-Challenge"
    Day         = "7"
    Owner       = "MaVeN-13TTN"
    Challenge   = "File-Layout-Isolation"
    Environment = "staging"
    ManagedBy   = "Terraform"
  }
}
