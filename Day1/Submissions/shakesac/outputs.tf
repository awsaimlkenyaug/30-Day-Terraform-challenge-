output "bucket_arn" {
  # Invalid: Missing value
}

# Invalid: Malformed output block
output "bucket_id"
  value = aws_s3_bucket.invalid_bucket.id
  description = "The ID of the bucket"
}

output "bucket_domain_name" {
  value = aws_s3_bucket.invalid_bucket.website_endpoint
  # Invalid: Reference to non-existent attribute
}

# Invalid: Duplicate output name
output "bucket_arn" {
  value = aws_s3_bucket.invalid_bucket.arn
  description = "The ARN of the bucket"
} 