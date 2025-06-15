# Output the name of the created S3 bucket
output "s3_bucket_name" {
  value       = aws_s3_bucket.example.bucket
  description = "The name of the created S3 bucket"
}

# Output the ARN of the created S3 bucket
output "s3_bucket_arn" {
  value       = aws_s3_bucket.example.arn
  description = "The ARN of the created S3 bucket"
}
