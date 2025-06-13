variable "region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, production)"
  type        = string
  default     = "production"
}

variable "enable_s3" {
  description = "Flag to enable or disable S3 bucket creation"
  type        = bool
  default     = true
}
