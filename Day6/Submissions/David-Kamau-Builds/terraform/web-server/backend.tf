terraform {
  backend "s3" {
    bucket         = "day-6-test-tf-state-web-server"
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "day-6-test-locks-web-server"
    encrypt        = true
  }
}
