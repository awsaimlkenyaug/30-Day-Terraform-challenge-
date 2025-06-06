provider "aws" {
  region = var.region
}

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

# Use default subnet (public)
data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# IAM role for EC2 to allow SSM automation
resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach SSM and EC2 policies to the role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# IAM instance profile
resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

# Security group to allow HTTP and SSH
resource "aws_security_group" "single_server_sg" {
  name        = "single-server-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to your IP in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SSM Automation Document to change instance type
resource "aws_ssm_document" "change_instance_type" {
  name          = "ChangeInstanceType"
  document_type = "Automation"
  content = jsonencode({
    schemaVersion = "0.3"
    description   = "Change EC2 instance type to handle increased load"
    assumeRole    = aws_iam_role.ec2_ssm_role.arn
    parameters = {
      InstanceId = {
        type = "String"
        description = "ID of the EC2 instance"
      }
      InstanceType = {
        type = "String"
        description = "New instance type"
        default = var.scaled_instance_type
      }
    }
    mainSteps = [
      {
        name = "StopInstance"
        action = "aws:executeAwsApi"
        inputs = {
          Service = "ec2"
          Api = "StopInstances"
          InstanceIds = ["{{ InstanceId }}"]
        }
      },
      {
        name = "ChangeInstanceType"
        action = "aws:executeAwsApi"
        inputs = {
          Service = "ec2"
          Api = "ModifyInstanceAttribute"
          InstanceId = "{{ InstanceId }}"
          InstanceType = {
            Value = "{{ InstanceType }}"
          }
        }
      },
      {
        name = "StartInstance"
        action = "aws:executeAwsApi"
        inputs = {
          Service = "ec2"
          Api = "StartInstances"
          InstanceIds = ["{{ InstanceId }}"]
        }
      }
    ]
  })
}

# EC2 instance with Nginx and EBS optimization
resource "aws_instance" "single_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.single_server_sg.id]
  subnet_id     = data.aws_subnet.default.id
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
  ebs_optimized = true

  # EBS volume configuration
  root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              echo "<h1>Hello, World! Welcome to my scaled web server!</h1>" > /var/www/html/index.html
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Single-Server"
  }
}

# CloudWatch Alarm to trigger instance type change
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "single-server-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Trigger instance type upgrade when CPU exceeds ${var.cpu_threshold}%"
  alarm_actions       = [aws_ssm_document.change_instance_type.arn]
  dimensions = {
    InstanceId = aws_instance.single_server.id
  }
}