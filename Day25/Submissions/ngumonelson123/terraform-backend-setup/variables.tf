variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for remote state"
}

variable "dynamodb_table" {
  description = "DynamoDB table name for state locking"
}
