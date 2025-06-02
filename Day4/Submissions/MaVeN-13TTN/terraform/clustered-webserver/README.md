# Clustered Web Server Infrastructure

This Terraform configuration deploys a highly available clustered web server infrastructure on AWS using Auto Scaling Groups, Application Load Balancer, and CloudWatch monitoring.

## Architecture Overview

The infrastructure consists of:
- **Application Load Balancer (ALB)** - Distributes traffic across multiple instances
- **Auto Scaling Group (ASG)** - Manages instance lifecycle and scaling
- **Launch Template** - Defines instance configuration
- **Target Group** - Health checks and routing
- **Security Groups** - Network security
- **CloudWatch Alarms** - CPU-based auto scaling triggers

## Features

### High Availability
- Multi-AZ deployment across all available zones
- Auto Scaling Group with configurable min/max instances
- Application Load Balancer for traffic distribution
- Health checks with automatic instance replacement

### Auto Scaling
- CPU-based scaling policies
- CloudWatch alarms for scale up/down triggers
- Configurable thresholds and cooldown periods
- Instance refresh for rolling updates

### Security
- Security groups with least privilege access
- Optional SSH access with configurable CIDR blocks
- HTTPS support (when SSL certificate provided)
- Instance metadata security (IMDSv2)

### Monitoring
- Optional detailed CloudWatch monitoring
- Custom health check endpoints
- Load balancer access logs
- Instance status tracking

## Quick Start

### Prerequisites
- AWS CLI configured with appropriate credentials
- Terraform >= 1.0 installed
- EC2 Key Pair (optional, for SSH access)

### Deployment Steps

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Review the plan**
   ```bash
   terraform plan
   ```

3. **Deploy the infrastructure**
   ```bash
   terraform apply
   ```

4. **Access the application**
   - The load balancer DNS name will be displayed in the outputs
   - Access via: `http://<load_balancer_dns_name>`

### Clean Up
```bash
terraform destroy
```

## Configuration

### Key Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for deployment | `us-east-1` | No |
| `environment` | Environment name | `dev` | No |
| `instance_type` | EC2 instance type | `t3.micro` | No |
| `min_size` | Minimum instances in ASG | `2` | No |
| `max_size` | Maximum instances in ASG | `6` | No |
| `desired_capacity` | Desired instances in ASG | `3` | No |
| `enable_ssh_access` | Enable SSH access | `false` | No |
| `key_pair_name` | EC2 Key Pair name | `""` | No |
| `enable_https` | Enable HTTPS listener | `false` | No |
| `ssl_certificate_arn` | SSL certificate ARN | `""` | Conditional |

### Environment-Specific Configuration

The configuration supports multiple environments through variables:

- **Development**: Lower instance counts, relaxed security
- **Staging**: Production-like setup with monitoring
- **Production**: High availability, strict security, detailed monitoring

### Scaling Configuration

Auto scaling is configured with:
- **Scale Up**: When CPU > 70% for 2 consecutive periods
- **Scale Down**: When CPU < 30% for 2 consecutive periods
- **Cooldown**: 300 seconds between scaling activities

## Outputs

After deployment, the following information is available:

### Load Balancer
- DNS name and zone ID
- HTTP/HTTPS URLs
- Security group ID

### Auto Scaling Group
- ASG name and ARN
- Current capacity and limits
- Availability zones in use

### Network Information
- VPC and subnet IDs
- Security group configurations
- AMI details

## File Structure

```
clustered-webserver/
├── main.tf           # Main infrastructure configuration
├── variables.tf      # Input variable definitions
├── outputs.tf        # Output value definitions
├── terraform.tfvars  # Variable values
├── user-data.sh      # Instance initialization script
└── README.md         # This documentation
```

## Security Considerations

### Network Security
- ALB security group allows HTTP (80) and optionally HTTPS (443)
- Instance security group only allows traffic from ALB
- SSH access is disabled by default
- All outbound traffic allowed for updates and package installation

### Instance Security
- IMDSv2 enforced for metadata access
- Regular security updates via user data script
- Apache configured with security best practices
- Server tokens and signatures disabled

### Access Control
- No direct internet access to instances
- All traffic routed through load balancer
- Optional SSH access with configurable IP restrictions

## Monitoring and Logging

### CloudWatch Metrics
- CPU utilization for auto scaling
- Load balancer request metrics
- Instance health status
- Target group health

### Health Checks
- Load balancer health checks on HTTP endpoint
- Custom health check page at `/health.html`
- Server status endpoint at `/server-status`
- API status endpoint at `/api/status.json`

### Logging
- User data execution logs in `/var/log/user-data.log`
- Apache access and error logs
- CloudWatch agent (optional) for system metrics

## Troubleshooting

### Common Issues

1. **Instances failing health checks**
   - Check security group rules
   - Verify user data script execution
   - Review Apache configuration and logs

2. **Auto scaling not working**
   - Verify CloudWatch alarms are configured
   - Check IAM permissions for Auto Scaling
   - Review scaling policies and thresholds

3. **Load balancer not accessible**
   - Check security group rules for ALB
   - Verify target group health
   - Confirm DNS resolution

### Debugging Commands

```bash
# Check instance status
aws ec2 describe-instances --filters "Name=tag:Project,Values=terraform-challenge"

# Check Auto Scaling Group
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names <asg-name>

# Check target group health
aws elbv2 describe-target-health --target-group-arn <target-group-arn>

# Check CloudWatch alarms
aws cloudwatch describe-alarms --alarm-names <alarm-name>
```

## Cost Optimization

### Resource Costs
- **EC2 Instances**: Primary cost component
- **Load Balancer**: Fixed hourly cost + data processing
- **Data Transfer**: Outbound internet traffic
- **CloudWatch**: Metrics and logs storage

### Optimization Tips
- Use appropriate instance types for workload
- Implement proper auto scaling policies
- Monitor and adjust scaling thresholds
- Clean up unused resources regularly

## Advanced Configuration

### HTTPS Setup
To enable HTTPS:
1. Obtain SSL certificate in AWS Certificate Manager
2. Set `enable_https = true`
3. Provide `ssl_certificate_arn`

### Custom Domain
To use a custom domain:
1. Create Route 53 hosted zone
2. Add ALIAS record pointing to load balancer
3. Update SSL certificate for custom domain

### Monitoring Enhancement
For enhanced monitoring:
1. Enable detailed CloudWatch monitoring
2. Set up CloudWatch agent on instances
3. Configure custom metrics and dashboards
4. Set up SNS notifications for alarms

## References

- [AWS Auto Scaling User Guide](https://docs.aws.amazon.com/autoscaling/ec2/userguide/)
- [Application Load Balancer Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

## Support

For issues and questions:
- Review the troubleshooting section
- Check AWS CloudTrail for API errors
- Validate Terraform state consistency
- Contact the infrastructure team for assistance
