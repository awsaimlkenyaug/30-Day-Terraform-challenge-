#!/bin/bash

set -e

ENVIRONMENT=${1:-dev}

if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|production)$ ]]; then
    echo "Error: Environment must be dev, staging, or production"
    echo "Usage: $0 <environment>"
    exit 1
fi

echo "🔍 Validating Docker deployment in $ENVIRONMENT environment..."

cd terraform

# Check if Terraform outputs are available
if ! terraform output > /dev/null 2>&1; then
    echo "❌ Terraform outputs not available. Run terraform apply first."
    exit 1
fi

ASG_NAME=$(terraform output -raw asg_name 2>/dev/null || echo "")
ALB_DNS=$(terraform output -raw alb_dns_name 2>/dev/null || echo "")

echo "📋 Environment: $ENVIRONMENT"
echo "📋 ASG Name: $ASG_NAME"

# Check ASG health
echo ""
echo "🔍 Checking Auto Scaling Group..."
ASG_STATUS=$(aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "$ASG_NAME" \
    --query 'AutoScalingGroups[0].{DesiredCapacity:DesiredCapacity,Instances:length(Instances[?LifecycleState==`InService`])}' \
    --output text)

DESIRED=$(echo $ASG_STATUS | cut -d' ' -f1)
RUNNING=$(echo $ASG_STATUS | cut -d' ' -f2)

echo "   Desired instances: $DESIRED"
echo "   Running instances: $RUNNING"

if [ "$DESIRED" -eq "$RUNNING" ]; then
    echo "   ✅ ASG is healthy"
else
    echo "   ⚠️  ASG is scaling or has issues"
fi

# Check ALB if deployed
if [[ "$ALB_DNS" != *"not deployed"* ]]; then
    echo ""
    echo "🔍 Checking Application Load Balancer..."
    echo "   ALB DNS: $ALB_DNS"
    
    # Test ALB connectivity
    if curl -s -o /dev/null -w "%{http_code}" "http://$ALB_DNS" | grep -q "200\|301\|302"; then
        echo "   ✅ ALB is responding"
        
        # Check target group health
        TG_ARN=$(aws elbv2 describe-target-groups \
            --names "${ENVIRONMENT}-web-tg" \
            --query 'TargetGroups[0].TargetGroupArn' \
            --output text 2>/dev/null || echo "")
        
        if [ -n "$TG_ARN" ]; then
            HEALTHY_TARGETS=$(aws elbv2 describe-target-health \
                --target-group-arn "$TG_ARN" \
                --query 'length(TargetHealthDescriptions[?TargetHealth.State==`healthy`])' \
                --output text)
            
            echo "   Healthy targets: $HEALTHY_TARGETS"
            
            if [ "$HEALTHY_TARGETS" -gt 0 ]; then
                echo "   ✅ Target group has healthy instances"
            else
                echo "   ⚠️  No healthy targets in target group"
            fi
        fi
    else
        echo "   ❌ ALB is not responding"
    fi
fi

# Check Docker containers on instances
echo ""
echo "🔍 Checking Docker containers..."

INSTANCE_IDS=$(aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "$ASG_NAME" \
    --query 'AutoScalingGroups[0].Instances[?LifecycleState==`InService`].InstanceId' \
    --output text)

CONTAINER_COUNT=0
TOTAL_INSTANCES=0

for INSTANCE_ID in $INSTANCE_IDS; do
    TOTAL_INSTANCES=$((TOTAL_INSTANCES + 1))
    echo "   Checking instance $INSTANCE_ID..."
    
    # Check if Docker container is running via SSM
    COMMAND_ID=$(aws ssm send-command \
        --instance-ids "$INSTANCE_ID" \
        --document-name "AWS-RunShellScript" \
        --parameters 'commands=["docker ps | grep simi-ops-app || echo CONTAINER_NOT_FOUND"]' \
        --output text \
        --query 'Command.CommandId' 2>/dev/null || echo "")
    
    if [ -n "$COMMAND_ID" ]; then
        # Wait a moment for command to execute
        sleep 3
        
        RESULT=$(aws ssm get-command-invocation \
            --command-id "$COMMAND_ID" \
            --instance-id "$INSTANCE_ID" \
            --query 'StandardOutputContent' \
            --output text 2>/dev/null || echo "")
        
        if [[ "$RESULT" != *"CONTAINER_NOT_FOUND"* ]] && [ -n "$RESULT" ]; then
            echo "     ✅ Docker container is running"
            CONTAINER_COUNT=$((CONTAINER_COUNT + 1))
        else
            echo "     ❌ Docker container not found"
        fi
    else
        echo "     ⚠️  Could not check container (SSM may not be available)"
    fi
done

echo ""
echo "📊 Deployment Summary:"
echo "   Environment: $ENVIRONMENT"
echo "   ASG Status: $RUNNING/$DESIRED instances running"
echo "   Docker Containers: $CONTAINER_COUNT/$TOTAL_INSTANCES containers running"

if [[ "$ALB_DNS" != *"not deployed"* ]]; then
    echo "   Load Balancer: http://$ALB_DNS"
fi

echo ""

# Overall health assessment
if [ "$DESIRED" -eq "$RUNNING" ] && [ "$CONTAINER_COUNT" -gt 0 ]; then
    echo "🎉 Deployment appears to be successful!"
    
    if [[ "$ALB_DNS" != *"not deployed"* ]]; then
        echo "🌐 Your application should be available at: http://$ALB_DNS"
    else
        echo "🌐 Access your application using individual instance public IPs"
    fi
else
    echo "⚠️  Deployment may have issues. Check the details above."
fi

echo ""
echo "💡 Tips:"
echo "   - Allow 2-3 minutes for instances to fully initialize"
echo "   - Check AWS Console for detailed logs and metrics"
echo "   - Use 'docker logs simi-ops-app' on instances for container logs"