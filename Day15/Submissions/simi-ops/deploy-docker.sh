#!/bin/bash

set -e

ENVIRONMENT=${1:-dev}
DOCKER_IMAGE=${2:-simimwanza/simi-ops}

if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|production)$ ]]; then
    echo "Error: Environment must be dev, staging, or production"
    echo "Usage: $0 <environment> [docker-image]"
    exit 1
fi

echo "🐳 Deploying Docker image $DOCKER_IMAGE to $ENVIRONMENT environment..."

cd terraform

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Apply the changes to deploy with Docker
echo "🔨 Applying Docker deployment to $ENVIRONMENT..."
terraform apply -var-file="environments/$ENVIRONMENT/terraform.tfvars" -auto-approve

# Get the ASG name and ALB DNS
ASG_NAME=$(terraform output -raw asg_name 2>/dev/null || echo "")
ALB_DNS=$(terraform output -raw alb_dns_name 2>/dev/null || echo "")

echo ""
echo "✅ Docker deployment completed for $ENVIRONMENT!"
echo ""
echo "📋 Deployment Summary:"
echo "   Environment: $ENVIRONMENT"
echo "   Docker Image: $DOCKER_IMAGE"
echo "   ASG Name: $ASG_NAME"
if [[ "$ALB_DNS" != *"not deployed"* ]]; then
    echo "   Load Balancer: http://$ALB_DNS"
fi
echo ""
echo "🔄 The Auto Scaling Group will automatically replace instances with the new Docker configuration."
echo "   This may take a few minutes to complete."
echo ""

# If ALB is deployed, show the URL
if [[ "$ALB_DNS" != *"not deployed"* ]]; then
    echo "🌐 Your application will be available at: http://$ALB_DNS"
    echo "   Note: It may take 2-3 minutes for the health checks to pass."
else
    echo "🌐 Since ALB is not deployed in this environment, you can access instances directly."
    echo "   Use 'terraform output' to get instance public IPs."
fi

echo ""
echo "📊 To monitor the deployment:"
echo "   - Check AWS Console > EC2 > Auto Scaling Groups > $ASG_NAME"
echo "   - Monitor instance refresh progress"
echo "   - Check target group health if ALB is deployed"