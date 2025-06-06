provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "workspace_demo" {
  bucket = "workspace-demo-${terraform.workspace}"  # Bucket name changes per workspace
  acl    = "private"
}