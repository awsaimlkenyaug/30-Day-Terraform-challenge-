# main.tf
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  description = "AWS named profile"
}


resource "aws_s3_bucket" "example" {
  bucket = "my-app-${terraform.workspace}-bucket"
  acl    = "private"
}
