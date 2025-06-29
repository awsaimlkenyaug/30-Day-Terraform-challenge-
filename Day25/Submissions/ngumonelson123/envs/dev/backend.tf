terraform {
  backend "s3" {
    bucket         = "ngumonelson123-tfstate"
    key            = "day25/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
