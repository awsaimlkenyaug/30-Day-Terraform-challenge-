variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}
