terraform {
  backend "s3" {
    bucket         = "terraform-bucket-denis-418272768275"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
