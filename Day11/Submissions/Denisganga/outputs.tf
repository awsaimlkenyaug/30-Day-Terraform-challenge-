output "s3_bucket_name" {
  value = length(aws_s3_bucket.conditional_bucket) > 0 ? aws_s3_bucket.conditional_bucket[0].id : ""
}
