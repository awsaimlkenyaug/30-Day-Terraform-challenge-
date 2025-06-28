variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "s3_bucket_website_endpoint" {
  description = "Website endpoint of the S3 bucket"
  type        = string
}

variable "default_root_object" {
  description = "Default object to serve (usually index.html)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to CloudFront distribution"
  type        = map(string)
}
