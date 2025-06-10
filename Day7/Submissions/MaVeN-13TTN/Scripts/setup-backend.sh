#!/bin/bash

# Day 7 - Setup S3 Backend for Terraform State
# This script creates the required S3 bucket and DynamoDB table for Terraform state management

set -e

# Configuration
BUCKET_NAME="maven-13ttn-terraform-state-bucket"
DYNAMODB_TABLE="terraform-state-lock"
AWS_REGION="us-west-2"

echo "🚀 Setting up Terraform backend infrastructure..."
echo "================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if bucket exists
print_status $YELLOW "🪣 Checking if S3 bucket exists..."
if aws s3api head-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION" 2>/dev/null; then
    print_status $GREEN "✅ S3 bucket '$BUCKET_NAME' already exists"
else
    print_status $YELLOW "📦 Creating S3 bucket '$BUCKET_NAME'..."
    
    # Create bucket
    if [ "$AWS_REGION" = "us-east-1" ]; then
        aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION"
    else
        aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION" \
            --create-bucket-configuration LocationConstraint="$AWS_REGION"
    fi
    
    # Enable versioning
    print_status $YELLOW "🔄 Enabling versioning on S3 bucket..."
    aws s3api put-bucket-versioning --bucket "$BUCKET_NAME" \
        --versioning-configuration Status=Enabled
    
    # Enable encryption
    print_status $YELLOW "🔐 Enabling encryption on S3 bucket..."
    aws s3api put-bucket-encryption --bucket "$BUCKET_NAME" \
        --server-side-encryption-configuration '{
            "Rules": [
                {
                    "ApplyServerSideEncryptionByDefault": {
                        "SSEAlgorithm": "AES256"
                    },
                    "BucketKeyEnabled": true
                }
            ]
        }'
    
    # Block public access
    print_status $YELLOW "🚫 Blocking public access on S3 bucket..."
    aws s3api put-public-access-block --bucket "$BUCKET_NAME" \
        --public-access-block-configuration \
        BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
    
    print_status $GREEN "✅ S3 bucket '$BUCKET_NAME' created successfully"
fi

# Check if DynamoDB table exists
print_status $YELLOW "🗃️  Checking if DynamoDB table exists..."
if aws dynamodb describe-table --table-name "$DYNAMODB_TABLE" --region "$AWS_REGION" >/dev/null 2>&1; then
    print_status $GREEN "✅ DynamoDB table '$DYNAMODB_TABLE' already exists"
else
    print_status $YELLOW "📊 Creating DynamoDB table '$DYNAMODB_TABLE'..."
    
    aws dynamodb create-table \
        --table-name "$DYNAMODB_TABLE" \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
        --region "$AWS_REGION"
    
    print_status $YELLOW "⏳ Waiting for DynamoDB table to be active..."
    aws dynamodb wait table-exists --table-name "$DYNAMODB_TABLE" --region "$AWS_REGION"
    
    print_status $GREEN "✅ DynamoDB table '$DYNAMODB_TABLE' created successfully"
fi

print_status $BLUE "\n📋 Backend Configuration Summary:"
echo "  S3 Bucket: $BUCKET_NAME"
echo "  DynamoDB Table: $DYNAMODB_TABLE"
echo "  Region: $AWS_REGION"

print_status $GREEN "\n🎉 Backend infrastructure setup complete!"
print_status $YELLOW "You can now run 'terraform init' in your Terraform configurations."
