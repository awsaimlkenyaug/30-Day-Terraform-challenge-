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