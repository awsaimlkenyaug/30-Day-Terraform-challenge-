provider "aws" {
  region = "us-east-2"
}

# Input Variables
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 Instance Type"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 Instance"
  default     = "ami-0c55b2434c884811b" # Example: Ubuntu 20.04 in us-east-2
}

variable "key_name" {
  type        = string
  description = "Name of the SSH key pair"
  default     = "my-new-key" # Replace with your key pair name
}

# Data Source for VPC
data "aws_vpc" "default" {
  default = true
}

# Data Source for Subnet
data "aws_subnet" "default_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-2a"] # Replace with your desired AZ
  }

  default_for_az = true
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow inbound traffic on ports 80 and 22"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: Restrict this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Configurable Web Server (Single Instance)
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.default_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              echo "<h1>Hello, World from $(hostname)</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "Configurable-Web-Server"
  }
}

# Clustered Web Server (Multiple Instances)
resource "aws_instance" "web_server_cluster" {
  count                  = 2 # Number of instances in the cluster
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.default_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              echo "<h1>Hello, World from $(hostname) - Instance ${count.index + 1}</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "Clustered-Web-Server-${count.index + 1}"
  }
}

# Terraform Data Block - Lookup Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "public_ips" {
  value       = [aws_instance.web_server_cluster.*.public_ip]
  description = "Public IPs of the clustered web servers"
}
