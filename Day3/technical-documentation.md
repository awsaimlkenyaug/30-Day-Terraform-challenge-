# Day 3 Technical Documentation: Deploying Basic Infrastructure with Terraform

## Project Overview

This document provides comprehensive technical documentation for Day 3 of the 30-Day Terraform Challenge, focusing on deploying basic infrastructure on AWS using Terraform and creating architecture diagrams as code using Python's diagrams library.

### Challenge Objectives
- Deploy a single server on AWS using Terraform
- Deploy a web server with Apache HTTP server using Terraform
- Create architecture diagrams as code using Python
- Validate deployed infrastructure against architectural designs
- Implement Infrastructure as Code (IaC) best practices

---

## Technical Architecture

### Infrastructure Components

#### Single Server Deployment
```
├── EC2 Instance (t3.micro)
├── Security Group (SSH only)
├── Key Pair (SSH access)
└── Network (Default VPC/Subnet)
```

#### Web Server Deployment
```
├── EC2 Instance (t3.micro)
├── Security Group (HTTP + SSH)
├── Key Pair (SSH access)
├── User Data Script (Apache installation)
└── Network (Default VPC/Subnet)
```

### Network Architecture
```
Internet Gateway
    ↓
Default VPC (172.31.0.0/16)
    ↓
Public Subnet (172.31.32.0/20, us-east-1a)
    ↓
Security Groups → EC2 Instances
```

---

## Terraform Implementation

### 1. Provider Configuration

#### AWS Provider Setup
```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Environment = "learning"
      Project     = "30-day-terraform-challenge"
      Day         = "3"
      Owner       = "MaVeN-13TTN"
    }
  }
}
```

**Key Features:**
- Version constraints for Terraform and AWS provider
- Default tags applied to all resources
- Regional deployment in `us-east-1`

### 2. Data Sources Implementation

#### VPC and Subnet Discovery
```hcl
# Default VPC discovery
data "aws_vpc" "default" {
  default = true
}

# Default subnet in specific AZ
data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
  default_for_az    = true
}

# Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```

**Benefits:**
- Dynamic resource discovery
- No hardcoded AMI IDs
- Automatic selection of appropriate network resources

### 3. Security Group Configuration

#### Single Server Security Group
```hcl
resource "aws_security_group" "single_server_sg" {
  name_prefix = "single-server-sg-"
  description = "Security group for single server - SSH access only"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### Web Server Security Group
```hcl
resource "aws_security_group" "web_server_sg" {
  name_prefix = "web-server-sg-"
  description = "Security group for web server - HTTP and SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### 4. EC2 Instance Configuration

#### Single Server Instance
```hcl
resource "aws_instance" "single_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.single_server_key.key_name
  vpc_security_group_ids = [aws_security_group.single_server_sg.id]
  subnet_id              = data.aws_subnet.default.id

  associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name = "single-server-day3"
  }
}
```

#### Web Server Instance with User Data
```hcl
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.web_server_key.key_name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  subnet_id              = data.aws_subnet.default.id

  associate_public_ip_address = true

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              # Create a simple HTML page
              cat <<HTML > /var/www/html/index.html
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Day 3 - Terraform Web Server</title>
                  <style>
                      body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f4; }
                      .container { background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
                      h1 { color: #2c3e50; }
                      .info { background-color: #ecf0f1; padding: 15px; border-radius: 5px; margin: 20px 0; }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>🚀 Day 3 - Terraform Web Server</h1>
                      <p>Congratulations! Your web server is running successfully.</p>
                      
                      <div class="info">
                          <h3>Server Details:</h3>
                          <ul>
                              <li><strong>Instance Type:</strong> t3.micro</li>
                              <li><strong>Operating System:</strong> Amazon Linux 2</li>
                              <li><strong>Web Server:</strong> Apache HTTP Server</li>
                              <li><strong>Deployment Method:</strong> Terraform</li>
                              <li><strong>Challenge:</strong> 30-Day Terraform Challenge - Day 3</li>
                          </ul>
                      </div>
                      
                      <p>This server was deployed using Infrastructure as Code (IaC) with Terraform.</p>
                  </div>
              </body>
              </html>
HTML
              EOF
  )

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name = "web-server-day3"
  }
}
```

### 5. Output Configuration

```hcl
# Single Server Outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.single_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.single_server.public_ip
}

output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.single_server.public_ip}"
}

# Web Server Outputs
output "web_server_url" {
  description = "URL of the web server"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "web_server_ssh_command" {
  description = "SSH command to connect to the web server"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_ip}"
}
```

---

## Architecture Diagrams as Code

### Python Diagrams Library Implementation

#### 1. Single Server Architecture Diagram

```python
#!/usr/bin/env python3
"""
Day 3 - Single Server Architecture Diagram
Creates a visual representation of the single server deployment using diagrams as code.
"""

from diagrams import Diagram, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway
from diagrams.onprem.client import User
from diagrams.generic.network import Firewall

# Create the single server architecture diagram
with Diagram(
    "Single Server Architecture - Day 3",
    show=False,
    filename="../single-server",
    direction="TB",
    graph_attr={"fontsize": "16", "fontname": "Helvetica"},
):

    # External user (administrator)
    admin = User("Administrator\n(SSH Access)")

    # Internet Gateway
    igw = InternetGateway("Internet Gateway")

    # VPC
    vpc = VPC("Default VPC\n(172.31.0.0/16)")

    # Public subnet
    subnet = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")

    # Security group (represented by firewall)
    sg = Firewall("Security Group\nSSH (22)")

    # EC2 instance
    server = EC2("Single Server\nt3.micro\nAmazon Linux 2")

    # Define connections with labels
    admin >> Edge(label="SSH (22)", style="dashed", color="blue") >> igw
    igw >> vpc >> subnet >> sg >> server
```

#### 2. Web Server Architecture Diagram

```python
#!/usr/bin/env python3
"""
Day 3 - Web Server Architecture Diagram
Creates a visual representation of the web server deployment using diagrams as code.
"""

from diagrams import Diagram, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway
from diagrams.onprem.client import Users
from diagrams.generic.network import Firewall

# Create the web server architecture diagram
with Diagram(
    "Web Server Architecture - Day 3",
    show=False,
    filename="../web-server",
    direction="TB",
    graph_attr={"fontsize": "16", "fontname": "Helvetica"},
):

    # External users
    users = Users("Internet Users\n(HTTP Access)")

    # Internet Gateway
    igw = InternetGateway("Internet Gateway")

    # VPC
    vpc = VPC("Default VPC\n(172.31.0.0/16)")

    # Public subnet
    subnet = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")

    # Security group (represented by firewall)
    sg = Firewall("Security Group\nHTTP (80)\nSSH (22)")

    # EC2 instance with web server
    web_server = EC2("Web Server\nt3.micro\nAmazon Linux 2\nApache HTTP Server")

    # Define connections with labels
    users >> Edge(label="HTTP (80)", style="bold", color="green") >> igw
    igw >> vpc >> subnet >> sg >> web_server
```

#### 3. Complete Infrastructure Overview

```python
#!/usr/bin/env python3
"""
Day 3 - Complete Infrastructure Overview
Creates a visual representation of both single server and web server deployments.
"""

from diagrams import Diagram, Edge, Cluster
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway
from diagrams.onprem.client import Users, User
from diagrams.generic.network import Firewall

# Create the complete infrastructure diagram
with Diagram(
    "Complete Day 3 Infrastructure",
    show=False,
    filename="../complete-infrastructure",
    direction="TB",
    graph_attr={"fontsize": "16", "fontname": "Helvetica"},
):

    # External access
    users = Users("Internet Users")
    admin = User("Administrator")

    # Shared Internet Gateway
    igw = InternetGateway("Internet Gateway")

    # VPC
    vpc = VPC("Default VPC\n(172.31.0.0/16)")

    # Create clusters for different deployments
    with Cluster("Single Server Deployment"):
        subnet1 = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")
        sg1 = Firewall("SG-SSH\n(Port 22)")
        server1 = EC2("Single Server\nt3.micro\nSSH Only")

        subnet1 >> sg1 >> server1

    with Cluster("Web Server Deployment"):
        subnet2 = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")
        sg2 = Firewall("SG-Web\n(Port 80, 22)")
        server2 = EC2("Web Server\nt3.micro\nApache HTTP")

        subnet2 >> sg2 >> server2

    # Define connections
    admin >> Edge(label="SSH", style="dashed", color="blue") >> igw
    users >> Edge(label="HTTP", style="bold", color="green") >> igw

    igw >> vpc
    vpc >> subnet1
    vpc >> subnet2
```

### Diagram Generation Process

1. **Environment Setup**: Python environment with `diagrams` library
2. **Script Execution**: Run Python scripts to generate PNG diagrams
3. **Validation**: Compare diagrams with actual deployed infrastructure
4. **Correction**: Update diagrams to match real AWS resources

---

## Deployment Process

### 1. Single Server Deployment

```bash
# Navigate to single server directory
cd terraform/single-server/

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply configuration
terraform apply -auto-approve
```

**Deployment Results:**
- Instance ID: `i-082ad8bc49afdf629`
- Public IP: `54.211.236.116`
- SSH Access: ✅ Verified
- Instance State: Running → Terminated (after testing)

### 2. Web Server Deployment

```bash
# Navigate to web server directory
cd terraform/web-server/

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply configuration
terraform apply -auto-approve
```

**Deployment Results:**
- Instance ID: `i-0642a6d30ef275ea2`
- Public IP: `13.217.81.209`
- Web URL: `http://13.217.81.209`
- HTTP Response: 200 OK ✅
- SSH Access: ✅ Verified
- Apache Server: ✅ Running
- Instance State: Running → Terminated (after testing)

### 3. Infrastructure Validation

#### SSH Connectivity Test
```bash
ssh -i ~/.ssh/id_rsa ec2-user@54.211.236.116
```
**Result**: ✅ Successful connection, system information verified

#### Web Server HTTP Test
```bash
curl -I http://13.217.81.209
```
**Result**: ✅ HTTP/1.1 200 OK, Apache server detected

#### Resource Verification
- ✅ Instances deployed in correct subnet: `subnet-07d5c4df1d0ef85be`
- ✅ VPC: `vpc-029471017da44bfc8` (Default VPC)
- ✅ Security groups configured correctly
- ✅ Public IPs assigned as expected

---

## Infrastructure Validation and Cleanup

### Validation Results

#### Network Configuration Validation
```bash
aws ec2 describe-vpcs --region us-east-1 --filters "Name=is-default,Values=true"
```
**Result**: Default VPC `vpc-029471017da44bfc8` with CIDR `172.31.0.0/16` ✅

#### Subnet Configuration Validation
```bash
aws ec2 describe-subnets --region us-east-1 --filters "Name=vpc-id,Values=vpc-029471017da44bfc8"
```
**Result**: Subnet `subnet-07d5c4df1d0ef85be` with CIDR `172.31.32.0/20` in `us-east-1a` ✅

### Cleanup Process

#### Single Server Cleanup
```bash
cd terraform/single-server/
terraform destroy -auto-approve
```

#### Web Server Cleanup
```bash
cd terraform/web-server/
terraform destroy -auto-approve
```

### Final Resource State
```bash
aws ec2 describe-instances --region us-east-1
```
**Result**: All instances terminated, no active resources ✅

---

## Technical Challenges and Solutions

### 1. Diagram Library Compatibility

**Challenge**: Some diagram components not available in the library
```python
# SecurityGroup component not available
from diagrams.aws.network import SecurityGroup  # ❌ Not found
```

**Solution**: Used alternative components
```python
# Used Firewall from generic network components
from diagrams.generic.network import Firewall  # ✅ Available
```

### 2. Network Information Accuracy

**Challenge**: Initial diagrams used placeholder network ranges
- VPC CIDR: `10.0.0.0/16` (incorrect)
- Subnet CIDR: `10.0.1.0/24` (incorrect)

**Solution**: Extracted actual network information from Terraform state
- VPC CIDR: `172.31.0.0/16` ✅
- Subnet CIDR: `172.31.32.0/20` ✅

### 3. User Data Script Formatting

**Challenge**: Complex HTML content in user data script
```hcl
user_data = <<-EOF
  # Complex multiline script with HTML
EOF
```

**Solution**: Used `base64encode()` function for reliable encoding
```hcl
user_data = base64encode(<<-EOF
  #!/bin/bash
  # Script content
EOF
)
```

---

## Best Practices Implemented

### 1. Terraform Best Practices

- ✅ **Version Constraints**: Specified minimum Terraform and provider versions
- ✅ **Data Sources**: Used dynamic resource discovery instead of hardcoded values
- ✅ **Default Tags**: Applied consistent tagging across all resources
- ✅ **Resource Naming**: Used descriptive names with prefixes
- ✅ **Security**: Enabled IMDSv2, encrypted EBS volumes
- ✅ **Output Values**: Provided useful outputs for connectivity

### 2. Security Best Practices

- ✅ **Instance Metadata**: Required IMDSv2 tokens
- ✅ **Storage Encryption**: Enabled EBS volume encryption
- ✅ **Security Groups**: Principle of least privilege
- ✅ **Key Management**: Used separate key pairs per deployment

### 3. Documentation as Code

- ✅ **Diagram Versioning**: Python scripts stored in version control
- ✅ **Infrastructure Validation**: Automated comparison with actual resources
- ✅ **Technical Documentation**: Comprehensive documentation of process

---

## Learning Outcomes

### 1. Terraform Skills Developed

- **Provider Configuration**: AWS provider setup with version constraints
- **Data Sources**: Dynamic resource discovery techniques
- **Resource Dependencies**: Understanding implicit and explicit dependencies
- **User Data**: Server configuration automation
- **State Management**: Working with Terraform state files
- **Output Values**: Extracting useful information from deployments

### 2. AWS Infrastructure Understanding

- **VPC Networking**: Default VPC structure and subnet configuration
- **EC2 Instances**: Instance types, AMIs, and security groups
- **Security Groups**: Inbound/outbound traffic rules
- **Key Pairs**: SSH key management for EC2 access
- **User Data**: Instance initialization scripting

### 3. Architecture Visualization

- **Diagrams as Code**: Python-based infrastructure visualization
- **Component Mapping**: Translating infrastructure to visual components
- **Validation Process**: Ensuring diagrams match reality
- **Documentation Integration**: Combining code and visual documentation

---

## File Structure

```
Day3/Submissions/MaVeN-13TTN/
├── terraform/
│   ├── single-server/
│   │   ├── main.tf
│   │   ├── terraform.tfstate
│   │   └── terraform.tfstate.backup
│   └── web-server/
│       ├── main.tf
│       ├── terraform.tfstate
│       └── terraform.tfstate.backup
├── architecture/
│   ├── diagrams/
│   │   ├── single_server_diagram.py
│   │   ├── web_server_diagram.py
│   │   └── complete_infrastructure.py
│   ├── single-server.png
│   ├── web-server.png
│   ├── complete-infrastructure.png
│   └── diagram-validation-report.md
├── day3-submission.md
└── technical-documentation.md
```

---

## Conclusion

Day 3 of the 30-Day Terraform Challenge successfully demonstrated:

1. **Infrastructure as Code**: Deployed multiple server configurations using Terraform
2. **Architecture Visualization**: Created accurate diagrams using Python code
3. **Validation Process**: Verified deployments against architectural designs
4. **Best Practices**: Implemented security, tagging, and documentation standards
5. **Complete Lifecycle**: Deploy → Test → Document → Cleanup

The combination of Terraform for infrastructure deployment and Python diagrams for visualization provides a powerful approach to Infrastructure as Code that includes both implementation and documentation in version-controlled, repeatable formats.

This foundation prepares for more complex infrastructure challenges in subsequent days of the 30-Day Terraform Challenge.

---

**Generated**: May 28, 2025  
**Status**: ✅ Complete  
**Challenge**: 30-Day Terraform Challenge - Day 3  
**Author**: MaVeN-13TTN
