terraform {
  backend "s3" {
    bucket         = "day-6-test-tf-state-single-server"
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "day-6-test-locks-single-server"
    encrypt        = true
  }
}
