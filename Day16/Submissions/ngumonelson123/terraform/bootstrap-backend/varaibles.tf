variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "tfstate-ngumonelson123"
}

variable "dynamodb_table" {
  default = "terraform-lock"
}
