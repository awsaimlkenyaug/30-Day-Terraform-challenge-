variable "region" {
  type        = string
  description = "AWS region where the S3 bucket will be created"
  default     = "us-east-1"
  
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "acl" {
  type        = string
  description = "ACL for the bucket"
  default     = "private"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the bucket"
  default     = {}
}
