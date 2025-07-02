# Docker Deployment Guide

This guide explains how to deploy the `simimwanza/simi-ops` Docker image to your EC2 infrastructure.

## Overview

The infrastructure has been updated to support Docker deployments with:
- Automatic Docker installation on EC2 instances
- Container health monitoring and auto-restart
- Zero-downtime deployment via Auto Scaling Group refresh
- Fallback to Apache if Docker fails

## Quick Deployment

### Option 1: Full Infrastructure Deployment (Recommended)

Deploy the entire infrastructure with Docker support:

```bash
# Deploy to development environment
./deploy-docker.sh dev

# Deploy to staging environment  
./deploy-docker.sh staging

# Deploy to production environment
./deploy-docker.sh production
```

### Option 2: Update Existing Instances

Update Docker containers on existing running instances:

```bash
# Update containers in development
./update-docker-instances.sh dev

# Update containers in staging
./update-docker-instances.sh staging

# Update containers in production
./update-docker-instances.sh production
```

## What Happens During Deployment

1. **Docker Installation**: Each EC2 instance installs Docker automatically
2. **Image Pull**: The `simimwanza/simi-ops` image is pulled from Docker Hub
3. **Container Start**: Container runs on port 80 with auto-restart policy
4. **Health Monitoring**: Cron job checks container health every 5 minutes
5. **Fallback**: Apache serves a status page if Docker fails

## Deployment Architecture

```
Internet → ALB → Target Group → ASG → EC2 Instances → Docker Containers
                                                    ↓
                                              simimwanza/simi-ops:latest
```

## Environment-Specific Configurations

| Environment | Instances | Instance Type | Docker Features |
|-------------|-----------|---------------|-----------------|
| dev         | 1-2       | t3.micro      | Basic setup     |
| staging     | 2-4       | t3.small      | Health checks   |
| production  | 3-6       | t3.medium     | Full monitoring |

## Monitoring Your Deployment

### Check Deployment Status

```bash
cd terraform

# Get deployment info
terraform output

# Check ASG status
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $(terraform output -raw asg_name)
```

### Access Your Application

- **With ALB**: `http://$(terraform output -raw alb_dns_name)`
- **Direct Instance**: Use instance public IPs from `terraform output`

### Monitor Container Health

SSH into an instance and run:

```bash
# Check running containers
docker ps

# Check container logs
docker logs simi-ops-app

# Check health check script
cat /tmp/health_check.sh
```

## Troubleshooting

### Container Not Starting

1. SSH into the instance
2. Check Docker status: `sudo systemctl status docker`
3. Check container logs: `docker logs simi-ops-app`
4. Manually restart: `docker restart simi-ops-app`

### Image Pull Issues

```bash
# Manually pull the image
docker pull simimwanza/simi-ops

# Check Docker Hub connectivity
curl -I https://registry-1.docker.io/v2/
```

### Health Check Failures

```bash
# Check ALB target group health
aws elbv2 describe-target-health --target-group-arn $(terraform output -raw target_group_arn)

# Check container response
curl -I http://localhost/
```

## Updating Your Docker Image

### Method 1: Update Existing Instances (Fast)

```bash
./update-docker-instances.sh production simimwanza/simi-ops:v2.0
```

### Method 2: Rolling Update via ASG (Zero Downtime)

```bash
# Update the user data script with new image tag
# Then trigger ASG instance refresh
aws autoscaling start-instance-refresh --auto-scaling-group-name $(terraform output -raw asg_name)
```

## Security Considerations

- Docker daemon runs as root (standard configuration)
- Container runs on port 80 (mapped from host)
- Production environment has restricted SSH access
- All traffic flows through ALB in staging/production

## Rollback Procedure

If deployment fails:

```bash
# Option 1: Rollback via Terraform
terraform apply -var-file="environments/production/terraform.tfvars" -auto-approve

# Option 2: Manual container rollback
./update-docker-instances.sh production simimwanza/simi-ops:previous-tag

# Option 3: Emergency fallback to Apache
# SSH to instances and run: sudo systemctl start httpd
```

## Performance Optimization

### Production Recommendations

1. **Use specific image tags** instead of `latest`
2. **Pre-pull images** during AMI creation
3. **Configure container resource limits**
4. **Set up log rotation** for Docker logs

### Example Optimized Container Run

```bash
docker run -d \
  -p 80:80 \
  --name simi-ops-app \
  --restart unless-stopped \
  --memory="512m" \
  --cpus="0.5" \
  --log-driver=json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  simimwanza/simi-ops:v1.0
```

## Next Steps

1. **Set up CI/CD**: Automate deployments from your Git repository
2. **Add monitoring**: Integrate with CloudWatch for container metrics
3. **Implement blue-green**: Use multiple ASGs for zero-downtime deployments
4. **Add secrets management**: Use AWS Secrets Manager for sensitive data

## Support

For issues with this deployment:
1. Check the troubleshooting section above
2. Review AWS CloudWatch logs
3. Check Auto Scaling Group activity history
4. Verify Docker Hub image availability