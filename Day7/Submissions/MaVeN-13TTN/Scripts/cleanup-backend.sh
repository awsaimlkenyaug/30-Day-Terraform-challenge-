#!/bin/bash

# Day 7 - Cleanup S3 Backend and DynamoDB Table
# This script deletes the S3 bucket and DynamoDB table created by setup-backend.sh

set -e

# Configuration (must match setup-backend.sh)
BUCKET_NAME="maven-13ttn-terraform-state-bucket"
DYNAMODB_TABLE="terraform-state-lock"
AWS_REGION="us-west-2"

echo "🧹 Cleaning up Terraform backend infrastructure..."
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

# Warning message
print_status $RED "⚠️  WARNING: This will permanently delete the following resources:"
echo "  - S3 Bucket: $BUCKET_NAME (and all objects)"
echo "  - DynamoDB Table: $DYNAMODB_TABLE"
echo ""
print_status $YELLOW "Are you sure you want to continue? This action cannot be undone."
read -p "Type 'yes' to confirm deletion: " confirm

if [ "$confirm" != "yes" ]; then
    print_status $YELLOW "❌ Cleanup cancelled by user"
    exit 0
fi

echo ""
print_status $BLUE "🗂️  Starting cleanup process..."

# Delete S3 bucket and all objects
print_status $YELLOW "🪣 Checking if S3 bucket exists..."
if aws s3api head-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION" 2>/dev/null; then
    print_status $YELLOW "🧹 Deleting all objects in S3 bucket '$BUCKET_NAME'..."
    
    # Delete all object versions (including delete markers)
    aws s3api delete-objects --bucket "$BUCKET_NAME" \
        --delete "$(aws s3api list-object-versions --bucket "$BUCKET_NAME" \
        --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}' \
        --max-items 1000)" \
        --region "$AWS_REGION" 2>/dev/null || true
    
    # Delete any remaining delete markers
    aws s3api delete-objects --bucket "$BUCKET_NAME" \
        --delete "$(aws s3api list-object-versions --bucket "$BUCKET_NAME" \
        --query '{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}' \
        --max-items 1000)" \
        --region "$AWS_REGION" 2>/dev/null || true
    
    # Delete the bucket
    print_status $YELLOW "🗑️  Deleting S3 bucket '$BUCKET_NAME'..."
    aws s3api delete-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION"
    
    print_status $GREEN "✅ S3 bucket '$BUCKET_NAME' deleted successfully"
else
    print_status $BLUE "ℹ️  S3 bucket '$BUCKET_NAME' does not exist"
fi

# Delete DynamoDB table
print_status $YELLOW "🗃️  Checking if DynamoDB table exists..."
if aws dynamodb describe-table --table-name "$DYNAMODB_TABLE" --region "$AWS_REGION" >/dev/null 2>&1; then
    print_status $YELLOW "🗑️  Deleting DynamoDB table '$DYNAMODB_TABLE'..."
    
    aws dynamodb delete-table --table-name "$DYNAMODB_TABLE" --region "$AWS_REGION"
    
    print_status $YELLOW "⏳ Waiting for DynamoDB table to be deleted..."
    aws dynamodb wait table-not-exists --table-name "$DYNAMODB_TABLE" --region "$AWS_REGION"
    
    print_status $GREEN "✅ DynamoDB table '$DYNAMODB_TABLE' deleted successfully"
else
    print_status $BLUE "ℹ️  DynamoDB table '$DYNAMODB_TABLE' does not exist"
fi

print_status $GREEN "\n🎉 Backend infrastructure cleanup complete!"
print_status $BLUE "All resources have been successfully removed:"
echo "  ✅ S3 Bucket: $BUCKET_NAME (deleted)"
echo "  ✅ DynamoDB Table: $DYNAMODB_TABLE (deleted)"
echo ""
print_status $YELLOW "Note: Any local .terraform directories may still contain cached backend configuration."
print_status $YELLOW "You may want to run 'rm -rf .terraform' in your Terraform directories if needed."
