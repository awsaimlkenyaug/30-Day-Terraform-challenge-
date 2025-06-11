provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ✅ Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# ✅ Get all subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ✅ Create a security group to allow HTTP access
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ Launch Template with user data script
resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = "ami-0a7d80731ae1b2435"
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
echo "<h1>Hello, Auto Scaling!</h1>" > index.html
nohup busybox httpd -f -p ${var.server_port} &
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "terraform-asg-example"
    }
  }
}

# ✅ Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  name               = "web-asg"
  min_size           = 1
  max_size           = 2
  desired_capacity   = 1
  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  health_check_type = "EC2"
  force_delete      = true

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}
