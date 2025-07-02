# Day 15 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 11th June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 5 (Pages 160-169)
- [x] Completed Required Hands-on Labs
- [x] Refactored Terraform code to use conditionals for dynamic infrastructure deployment
- [x] Implemented Docker containerization for application deployment
- [x] Created automated deployment scripts for Docker integration

## Infrastructure Details

### Zero Downtime Deployment with Auto Scaling Groups

Successfully implemented zero downtime deployment using:

1. **Auto Scaling Group with Launch Templates**
   - Replaced deprecated Launch Configurations with Launch Templates
   - `create_before_destroy = true` ensures seamless updates
   - Rolling instance refresh with 90% min healthy instances for production

2. **Environment-specific Resource Deployment**
   - **Production**: 3-6 instances, t3.medium, encrypted volumes, detailed monitoring
   - **Staging**: 2-4 instances, t3.small, standard volumes
   - **Dev**: 1-2 instances, t3.micro, basic configuration

3. **Application Load Balancer Integration**
   - ELB health checks with 300s grace period
   - Production: 15s health check interval, `/health` endpoint
   - Session stickiness enabled for production
   - Deletion protection for production ALB

4. **Auto Scaling Policies**
   - Scale up: CPU > 70% (production) / 80% (dev/staging)
   - Scale down: CPU < 20%
   - CloudWatch alarms with 2-period evaluation

5. **Deployed Infrastructure**
   - **ASG Name**: `production-web-asg`
   - **Launch Template**: `production-web-lt-20250627114459416500000001`
   - **ALB DNS**: `production-web-alb-933073628.us-east-1.elb.amazonaws.com`
   - **Region**: us-east-1 (production), us-west-2 (dev/staging)


## Infrastructure Diagram
Please see the `architecture/web-server.png` file for the infrastructure diagram.

## Blog Post
- **Title:** "Deploying Multi-Cloud Infrastructure with Terraform Modules"
- **Link:** [Blog Post](https://simiops.hashnode.dev/deploying-multi-cloud-infrastructure-with-terraform-modules)

## Social Media
- **Platform:** Twitter
- **Post Link:** [Twitter Post](https://x.com/simiOps/status/1938640628478329340)

## Notes and Observations

### Zero Downtime Deployment Implementation
- Successfully migrated from deprecated Launch Configurations to Launch Templates
- Implemented `create_before_destroy = true` lifecycle rules for seamless updates
- Rolling instance refresh ensures 90% healthy instances during deployments
- ELB health checks prevent traffic routing to unhealthy instances
- Auto Scaling policies provide automatic capacity management

### Key Achievements
- ✅ Zero downtime deployment capability
- ✅ Environment-specific conditional logic
- ✅ Production-grade security (encrypted volumes, restricted SSH)
- ✅ Cost optimization (different instance types per environment)
- ✅ Automated scaling based on CPU utilization
- ✅ Load balancer integration with health checks
- ✅ Docker containerization with `simimwanza/simi-ops` image
- ✅ Automated container health monitoring and restart
- ✅ Fallback mechanisms for high availability


## Additional Resources Used
- Terraform Documentation: https://www.terraform.io/docs/language/expressions/conditionals.html
- AWS Architecture Best Practices: https://aws.amazon.com/architecture/well-architected/

## Docker Integration

### Container Deployment
Successfully integrated Docker containerization:

1. **Docker Image Deployment**
   - Deployed `simimwanza/simi-ops` Docker image
   - Automatic Docker installation on EC2 instances
   - Container runs on port 80 with auto-restart policy

2. **Health Monitoring**
   - Automated health checks every 5 minutes via cron
   - Container auto-restart on failure
   - Apache fallback if Docker fails

3. **Deployment Scripts**
   - `deploy-docker.sh` - Full infrastructure deployment with Docker
   - `update-docker-instances.sh` - Update containers on existing instances
   - `validate-deployment.sh` - Health validation and monitoring

4. **Zero-Downtime Updates**
   - Rolling updates via Auto Scaling Group refresh
   - Instance replacement with new Docker configuration
   - Load balancer health checks ensure traffic continuity

### Usage
```bash
# Deploy Docker infrastructure
./deploy-docker.sh production

# Update existing containers
./update-docker-instances.sh production

# Validate deployment
./validate-deployment.sh production
```

## Time Spent
- Reading: [2 hours]
- Infrastructure Refactoring: [4 hours]
- Zero Downtime Implementation: [3 hours]
- Docker Integration: [3 hours]
- Deployment Scripts: [2 hours]
- Troubleshooting & Testing: [2 hours]
- Diagram Creation: [1 hour]
- Blog Writing: [2 hours]
- Total: [19 hours]

## Repository Structure
```
├── deploy-docker.sh            # Docker deployment script
├── update-docker-instances.sh  # Container update script
├── validate-deployment.sh      # Deployment validation script
├── DOCKER_DEPLOYMENT.md        # Docker deployment documentation
terraform/
├── main.tf                     # Main Terraform configuration with conditional resource deployment
├── variables.tf                # Variable definitions including environment-specific settings
├── deploy.sh                   # Deployment script for different environments
├── README.md                   # Documentation
├── environments/               # Environment-specific configurations
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── terraform.tfvars
│   └── production/
│       └── terraform.tfvars
├── modules/                    # Reusable Terraform modules with conditional logic
│   ├── alb/                    # Application Load Balancer module
│   │   ├── main.tf            # Includes conditional health checks and listeners
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── asg/                    # Auto Scaling Group module (NEW)
│   │   ├── main.tf            # Launch Templates with zero downtime deployment
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/                    # EC2 instance module
│   │   ├── main.tf            # Includes conditional instance counts and volume configurations
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── user_data.sh       # Original Apache deployment
│   │   └── docker_user_data.sh # Docker container deployment (NEW)
│   └── security_group/         # Security Group module
│       ├── main.tf            # Includes conditional security rules + Docker ports
│       ├── variables.tf
│       └── outputs.tf
```