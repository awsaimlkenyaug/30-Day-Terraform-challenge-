# # Create DynamoDB locking table
# aws dynamodb create-table \
#   --table-name tf_state_locks_20250602 \
#   --attribute-definitions AttributeName=LockID,AttributeType=S \
#   --key-schema AttributeName=LockID,KeyType=HASH \
#   --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
#   --region us-east-1

# # Create S3 bucket with versioning enabled
# aws s3api create-bucket \
#   --bucket tf-state-locking-20250602 \
#   --region us-east-1

# aws s3api put-bucket-versioning \
#   --bucket tf-state-locking-20250602 \
#   --versioning-configuration Status=Enabled


terraform {
  backend "s3" {
    bucket        = "tf-state-locking-20250602"
    key           = "terraform.tfstate"
    region        = "us-east-1"
    use_lock_file = true
    encrypt       = true
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "locktryout" {
  bucket = "tf-locking-20250602"

  tags = {
    Environment = "test"
    Owner       = "David Kamau"
  }
}

