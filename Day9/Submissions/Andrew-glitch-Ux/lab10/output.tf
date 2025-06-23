output "bucket_name" {
  value       = aws_s3_bucket.workspace_demo.bucket
  description = "The name of the S3 bucket created"
}
