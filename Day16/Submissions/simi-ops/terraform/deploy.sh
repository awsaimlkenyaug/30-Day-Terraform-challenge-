#!/bin/bash

set -e

ENVIRONMENT=${1:-dev}
ACTION=${2:-plan}

if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|production)$ ]]; then
    echo "Error: Environment must be dev, staging, or production"
    exit 1
fi

echo "🚀 Deploying to $ENVIRONMENT environment..."

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan or apply
case $ACTION in
    plan)
        echo "📋 Planning deployment for $ENVIRONMENT..."
        terraform plan -var-file="environments/$ENVIRONMENT/terraform.tfvars"
        ;;
    apply)
        echo "🔨 Applying changes to $ENVIRONMENT..."
        terraform apply -var-file="environments/$ENVIRONMENT/terraform.tfvars" -auto-approve
        ;;
    destroy)
        echo "💥 Destroying resources in $ENVIRONMENT..."
        terraform destroy -var-file="environments/$ENVIRONMENT/terraform.tfvars" -auto-approve
        ;;
    *)
        echo "Error: Action must be plan, apply, or destroy"
        exit 1
        ;;
esac

echo "✅ Deployment completed for $ENVIRONMENT!"