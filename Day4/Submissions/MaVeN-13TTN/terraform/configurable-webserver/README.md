# Day 4 - Configurable Web Server

A highly configurable web server deployment using Terraform variables, demonstrating Infrastructure as Code best practices.

## 🎯 Objectives

- Learn to use Terraform input variables for configuration flexibility
- Implement conditional resources and dynamic blocks
- Practice with data sources and outputs
- Deploy a web server that can be easily customized

## 📁 Files Structure

```
configurable-webserver/
├── main.tf           # Main infrastructure configuration
├── variables.tf      # Input variable definitions with validation
├── outputs.tf        # Output values for deployed resources
├── terraform.tfvars  # Example variable values
├── user-data.sh      # Web server configuration script
└── README.md         # This documentation
```

## 🔧 Key Features

### Variables Used
- **AWS Configuration**: Region, availability zone
- **Instance Settings**: Type, security, monitoring
- **Server Configuration**: Port, SSL, custom content
- **Network Settings**: CIDR blocks, Elastic IP
- **Security Options**: SSH access, encryption

### Conditional Resources
- SSH access (can be disabled)
- HTTPS support (optional)
- Key pair creation (optional)
- Elastic IP allocation (optional)

### Dynamic Blocks
- Security group rules based on configuration
- Conditional ingress rules for SSH and HTTPS

## 🚀 Deployment Instructions

### Prerequisites
1. AWS CLI configured with appropriate credentials
2. Terraform installed (>= 1.0)
3. SSH key pair available (if SSH access enabled)

### Step 1: Initialize Terraform
```bash
cd Day4/Submissions/MaVeN-13TTN/terraform/configurable-webserver
terraform init
```

### Step 2: Review Configuration
```bash
# Check the plan
terraform plan

# Review variables
terraform plan -var-file="terraform.tfvars"
```

### Step 3: Deploy
```bash
terraform apply
```

### Step 4: Test
```bash
# Get outputs
terraform output

# Test web server
curl http://$(terraform output -raw instance_public_ip)

# SSH to server (if enabled)
ssh -i ~/.ssh/id_rsa ec2-user@$(terraform output -raw instance_public_ip)
```

## ⚙️ Configuration Options

### Basic Configuration
```hcl
# terraform.tfvars
server_name   = "my-web-server"
instance_type = "t3.micro"
server_port   = 80
environment   = "learning"
```

### Advanced Configuration
```hcl
# Enable HTTPS and detailed monitoring
enable_https              = true
enable_detailed_monitoring = true
allocate_eip              = true

# Custom security
ssh_cidr_blocks = ["10.0.0.0/8"]  # Restrict SSH
http_cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
```

### Custom Content
```hcl
custom_html_content = "Welcome to my configurable web server!"
```

## 📊 Outputs

The configuration provides comprehensive outputs:

- **Instance Information**: ID, IPs, DNS names
- **Network Details**: VPC, subnet, security group
- **Access Information**: URLs, SSH commands
- **Configuration Summary**: Applied settings

## 🔍 Key Learning Points

1. **Variable Validation**: Input validation rules
2. **Conditional Logic**: Resources created based on variables
3. **Dynamic Blocks**: Flexible security group rules
4. **Data Sources**: Fetching existing AWS resources
5. **Template Files**: Dynamic user data generation
6. **Output Values**: Exposing infrastructure information

## 🛡️ Security Considerations

- **SSH Access**: Can be disabled via variables
- **CIDR Restrictions**: Configurable access control
- **Encryption**: EBS encryption enabled by default
- **IMDSv2**: Instance metadata service v2 enforced
- **Security Groups**: Minimal required access

## 🔧 Troubleshooting

### Common Issues

1. **Key Pair Error**: Ensure SSH public key exists at specified path
2. **Permission Denied**: Check AWS credentials and IAM permissions
3. **Port Access**: Verify security group rules and server port
4. **User Data**: Check `/var/log/user-data.log` on the instance

### Useful Commands
```bash
# Check instance status
aws ec2 describe-instances --instance-ids $(terraform output -raw instance_id)

# View user data logs
ssh ec2-user@$(terraform output -raw instance_public_ip) 'sudo tail -f /var/log/user-data.log'

# Test local connectivity
curl -v http://$(terraform output -raw instance_public_ip):$(terraform output -raw server_port)
```

## 🧹 Cleanup

```bash
terraform destroy
```

## 📚 Related Resources

- [Terraform Variables Documentation](https://www.terraform.io/docs/configuration/variables.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Day 3 Simple Web Server](../../../Day3/Submissions/MaVeN-13TTN/terraform/web-server/)

---

**Part of the 30-Day Terraform Challenge - Day 4: Advanced Terraform Features**
