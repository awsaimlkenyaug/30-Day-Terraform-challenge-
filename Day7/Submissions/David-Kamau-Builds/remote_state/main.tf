# # Create DynamoDB locking table
# aws dynamodb create-table \
#   --table-name tf_remote_state_locks_20250602 \
#   --attribute-definitions AttributeName=LockID,AttributeType=S \
#   --key-schema AttributeName=LockID,KeyType=HASH \
#   --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
#   --region us-east-1

# # Create S3 bucket with versioning enabled
# aws s3api create-bucket \
#   --bucket david-tf-remote-state-20250602 \
#   --region us-east-1

# aws s3api put-bucket-versioning \
#   --bucket david-tf-remote-state-20250602 \
#   --versioning-configuration Status=Enabled


terraform {
  backend "s3" {
    bucket         = "david-tf-remote-state-20250602"
    key            = "bonus_remote_test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf_remote_state_locks_20250602"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "tf-remote-20250602"

  tags = {
    Environment = "RemoteTesting"
    Owner       = "David Kamau"
  }
}