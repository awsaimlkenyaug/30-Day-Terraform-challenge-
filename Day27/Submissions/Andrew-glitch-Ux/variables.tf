variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to store the Terraform state"
  type        = string
}

variable "s3_state_key" {
  description = "Path (key) within the S3 bucket for the state file"
  type        = string
}
