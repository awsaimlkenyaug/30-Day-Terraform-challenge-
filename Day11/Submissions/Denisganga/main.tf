provider "aws" {
  region = var.region
}
resource "aws_s3_bucket" "conditional_bucket" {
  count  = var.region == "us-east-1" && var.environment == "production" && var.enable_s3 ? 1 : 0
  bucket = "my-conditional-bucket-${var.environment}"
}
