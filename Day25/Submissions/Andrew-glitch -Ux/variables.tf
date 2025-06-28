variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "backend_bucket" {
  description = "S3 bucket for remote state"
  type        = string
}

variable "backend_key" {
  description = "Path in the S3 bucket to store the state file"
  type        = string
}

variable "backend_lock_table" {
  description = "DynamoDB table for state locking"
  type        = string
}
