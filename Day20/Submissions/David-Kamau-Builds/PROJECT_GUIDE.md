# Web Server Deployment Project

## Project Overview
This project demonstrates a complete CI/CD pipeline for deploying a Node.js web application to AWS using Terraform and GitHub Actions.

## Architecture
- **Application**: Simple Node.js web server
- **Infrastructure**: AWS VPC, ALB, Auto Scaling Group, RDS MySQL
- **CI/CD**: GitHub Actions with HCP Terraform integration

## Prerequisites
1. AWS Account with appropriate permissions
2. HCP Terraform account and organization
3. GitHub repository (for CI/CD)

## Setup Steps

### 1. Configure HCP Terraform
```bash
# Set your API token
set TF_TOKEN_app_terraform_io=your-hcp-terraform-token
```

### 2. Update Configuration
- Edit `terraform/terraform-cloud.tf`
- Replace `your-org-name-here` with your HCP Terraform organization name

### 3. Generate SSH Key
```bash
cd terraform
ssh-keygen -t rsa -b 2048 -f id_rsa -N "" -C "terraform-key"
```

### 4. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Local Testing
```bash
# Test the Node.js application
cd application
npm install
npm test
npm start
```

## Expected Outcomes
- ✅ Load-balanced web application on AWS
- ✅ Auto-scaling EC2 instances (2-4 instances)
- ✅ RDS MySQL database
- ✅ Secure VPC with proper networking
- ✅ Automated CI/CD pipeline

## Accessing Your Application
After deployment, get the ALB DNS name from Terraform outputs:
```
http://your-alb-dns-name
```

## Cost Estimation
**AWS Free Tier Eligible: ~$0.50 for 30 minutes**

| Resource | Free Tier Coverage | 30min Cost |
|----------|-------------------|------------|
| EC2 Instances (2x t3.micro) | 750 hours/month free | $0.00 |
| RDS MySQL (db.t3.micro) | 750 hours/month free | $0.00 |
| EBS Storage (20GB) | 30GB free | $0.00 |
| Application Load Balancer | Not free tier | ~$0.50 |

**Total for 30 minutes: ~$0.50** (ALB charges ~$0.0225/hour)

**Note**: Free tier applies to new AWS accounts (first 12 months). Always run `terraform destroy` after testing.

## Cleanup
```bash
terraform destroy
```

## Testing the CI/CD Pipeline

### 1. Initialize Git Repository
```bash
cd c:/Users/david/Desktop/30_Days_Of_Terraform_Challenge_All_Days/Day17/David-Kamau-Builds/terraform/web-server
git init
git add .
git commit -m "Initial commit: Web server deployment pipeline"
```

### 2. Push to GitHub
```bash
# Create repository on GitHub first, then:
git remote add origin https://github.com/your-username/web-server-deployment.git
git branch -M main
git push -u origin main
```

### 3. Configure GitHub Secrets
Add these secrets in GitHub → Settings → Secrets and variables → Actions:
- `TF_API_TOKEN`: Your HCP Terraform API token
- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key

### 4. Test the Pipeline
- Make a change to `application/server.js`
- Commit and push to trigger the workflow
- Monitor the GitHub Actions tab

## Troubleshooting
- Ensure HCP Terraform organization exists
- Verify AWS credentials are configured
- Check that SSH key pair is generated
- Confirm all required variables are set
- Ensure GitHub secrets are properly configured