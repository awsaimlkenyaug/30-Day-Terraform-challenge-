terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}



provider "aws" {
  region = "us-east-1"
}

data "aws_secretsmanager_secret" "db_password" {
  name = "myapp/db-password"
}

data "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

locals {
  secret_string = jsondecode(data.aws_secretsmanager_secret_version.db_password_version.secret_string)
}

output "db_password" {
  value     = local.secret_string.password
  sensitive = true
}
