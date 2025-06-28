variable "bucket_name" {
  description = "Name of the S3 bucket to host the static website"
  type        = string
}

variable "index_document" {
  description = "Name of the index document for the static website"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Name of the error document for the static website"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "terraform-static-site"
  }
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "backend_bucket" {
  description = "S3 bucket name for Terraform backend"
  type        = string
}

variable "backend_key" {
  description = "Path to the state file inside the backend bucket"
  type        = string
}

variable "backend_lock_table" {
  description = "DynamoDB table used for state locking"
  type        = string
}



