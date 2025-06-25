# Day 4 - Architecture Diagrams

This folder contains the infrastructure architecture diagrams for Day 4 - Advanced Terraform Features.

## Generated Diagrams

### 1. Configurable Web Server Architecture (`configurable_webserver_architecture.png`)
**Infrastructure Components:**
- Single EC2 instance (t3.micro) running Apache HTTP Server
- Security Group with HTTP (80) and SSH (22) access
- Internet Gateway for public access
- CloudWatch monitoring (optional)
- Elastic IP assignment (configurable)
- SSH Key Pair (configurable)

**Key Features:**
- 20+ configurable variables for flexibility
- Conditional resource creation
- Dynamic security group rules
- Template-based user data script

### 2. Clustered Web Server Architecture (`clustered_webserver_architecture.png`)
**Infrastructure Components:**
- Application Load Balancer (ALB) for traffic distribution
- Auto Scaling Group (2-6 instances) across multiple AZs
- Launch Template with t3.micro instances
- Target Group with health checks
- CloudWatch alarms for CPU-based scaling
- Separate security groups for ALB and web servers

**Key Features:**
- High availability across multiple AZs (us-east-1a, us-east-1b, us-east-1c)
- Auto scaling based on CPU utilization (>70% scale out, <30% scale in)
- Load balancing with health checks
- Cross-zone load balancing enabled

## Creation Method
✅ **Generated using Python `diagrams` library (Diagrams as Code)**
- Automated generation from script
- Version controlled diagram definitions
- Consistent with actual Terraform infrastructure
- AWS official icons and styling

## Scripts
- `generate_configurable_diagram.py` - Creates configurable web server diagram
- `generate_clustered_diagram.py` - Creates clustered web server diagram

## Technical Accuracy
✅ Diagrams reflect actual deployed infrastructure:
- Based on real Terraform configurations in `../terraform/`
- Validated against AWS console resources
- Includes all security groups, networking, and scaling components
- Accurate resource relationships and data flows

---
*Generated on: June 2, 2025*  
*Infrastructure Status: ✅ Deployed and Tested*
