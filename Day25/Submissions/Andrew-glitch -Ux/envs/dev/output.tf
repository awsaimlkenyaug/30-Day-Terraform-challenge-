output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_static_website.bucket_name
}

output "s3_website_endpoint" {
  description = "The website endpoint of the S3 bucket"
  value       = module.s3_static_website.website_endpoint
}
