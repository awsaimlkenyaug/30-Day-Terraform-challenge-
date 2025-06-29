terraform {
  backend "s3" {
    bucket         = "tf-state-ngumonelson123"
    key            = "Day6/Submissions/nelson-ngumo/terraform/single-server/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
