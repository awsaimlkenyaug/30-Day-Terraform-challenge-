#!/bin/bash

set -e

ENVIRONMENT=${1:-dev}
DOCKER_IMAGE=${2:-simimwanza/simi-ops}

if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|production)$ ]]; then
    echo "Error: Environment must be dev, staging, or production"
    echo "Usage: $0 <environment> [docker-image]"
    exit 1
fi

echo "🔄 Updating Docker containers on existing instances in $ENVIRONMENT environment..."

cd terraform

# Get the ASG name
ASG_NAME=$(terraform output -raw asg_name 2>/dev/null || echo "")

if [ -z "$ASG_NAME" ]; then
    echo "❌ Could not find ASG name. Make sure Terraform has been applied."
    exit 1
fi

echo "📋 Found ASG: $ASG_NAME"

# Get instance IDs from the ASG
INSTANCE_IDS=$(aws autoscaling describe-auto-scaling-groups \
    --auto-scaling-group-names "$ASG_NAME" \
    --query 'AutoScalingGroups[0].Instances[?LifecycleState==`InService`].InstanceId' \
    --output text)

if [ -z "$INSTANCE_IDS" ]; then
    echo "❌ No running instances found in ASG $ASG_NAME"
    exit 1
fi

echo "🎯 Found instances: $INSTANCE_IDS"

# Update Docker containers on each instance
for INSTANCE_ID in $INSTANCE_IDS; do
    echo "🐳 Updating Docker container on instance $INSTANCE_ID..."
    
    # Create the update script
    UPDATE_SCRIPT="
#!/bin/bash
echo 'Pulling latest Docker image...'
docker pull $DOCKER_IMAGE

echo 'Stopping existing container...'
docker stop simi-ops-app || true
docker rm simi-ops-app || true

echo 'Starting new container...'
docker run -d -p 80:80 --name simi-ops-app --restart unless-stopped $DOCKER_IMAGE

echo 'Container updated successfully!'
docker ps | grep simi-ops-app
"

    # Execute the update script on the instance
    aws ssm send-command \
        --instance-ids "$INSTANCE_ID" \
        --document-name "AWS-RunShellScript" \
        --parameters "commands=[\"$UPDATE_SCRIPT\"]" \
        --output text \
        --query 'Command.CommandId' > /tmp/command_${INSTANCE_ID}.txt
    
    COMMAND_ID=$(cat /tmp/command_${INSTANCE_ID}.txt)
    echo "   Command ID: $COMMAND_ID"
done

echo ""
echo "✅ Update commands sent to all instances!"
echo ""
echo "📊 To check command status:"
for INSTANCE_ID in $INSTANCE_IDS; do
    COMMAND_ID=$(cat /tmp/command_${INSTANCE_ID}.txt)
    echo "   aws ssm get-command-invocation --command-id $COMMAND_ID --instance-id $INSTANCE_ID"
done

echo ""
echo "🔍 Monitor the updates:"
echo "   - Commands may take 1-2 minutes to execute"
echo "   - Check AWS Systems Manager > Run Command for detailed logs"
echo "   - Verify containers are running with: docker ps"

# Cleanup temp files
rm -f /tmp/command_*.txt