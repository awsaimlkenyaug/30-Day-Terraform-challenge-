terraform {
  backend "s3" {
    bucket         = var.s3_bucket_name
    key            = var.s3_state_key
    region         = var.aws_region
    use_lockfile   = true  
    encrypt        = true
  }
}
