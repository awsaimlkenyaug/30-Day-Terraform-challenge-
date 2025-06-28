terraform {
  backend "s3" {
    bucket         = var.backend_bucket
    key            = var.backend_key
    region         = var.aws_region
    dynamodb_table = var.backend_lock_table
    profile        = var.aws_profile
  }
}
