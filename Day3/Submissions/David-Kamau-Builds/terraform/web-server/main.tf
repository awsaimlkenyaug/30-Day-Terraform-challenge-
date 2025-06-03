data "aws_ami" "amazon_linux_2" {
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

locals {
  common_tags = {
    Project     = "WebServerApp"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Networking
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = merge(local.common_tags, { Name = "webapp-vpc" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.common_tags, { Name = "webapp-igw" })
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr1
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone1
  tags = merge(local.common_tags, { Name = "public-subnet-1" })
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr2
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone2
  tags = merge(local.common_tags, { Name = "public-subnet-2" })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.common_tags, { Name = "public-rt" })
}

resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Groups
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.common_tags, { Name = "alb-sg" })
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow traffic from ALB and SSH from admin IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.common_tags, { Name = "web-sg" })
}

# Load Balancer
resource "aws_lb" "alb" {
  name               = "webapp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  
  tags = merge(local.common_tags, { Name = "webapp-alb" })
}

resource "aws_lb_target_group" "web_tg" {
  name     = "webapp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  
  tags = local.common_tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# Launch Template and Auto Scaling Group
resource "aws_launch_template" "web" {
  name_prefix   = "web-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    cat > /var/www/html/index.html << WEBPAGE
    <html><head><title>Welcome</title></head><body>
    <h1>Web App with Auto Scaling 🚀</h1>
    <p>Server: $(hostname)</p>
    </body></html>
    WEBPAGE
  EOF
  )
  
  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, { Name = "webapp-instance" })
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                = "webapp-asg"
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4
  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id]
  
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  
  target_group_arns = [aws_lb_target_group.web_tg.arn]
  
  health_check_type         = "ELB"
  health_check_grace_period = 300
  
  tag {
    key                 = "Name"
    value               = "webapp-asg-instance"
    propagate_at_launch = true
  }
  
  dynamic "tag" {
  for_each = local.common_tags
  content {
    key                 = each.key
    value               = each.value
    propagate_at_launch = true
  }
}
}

# CloudWatch Monitoring
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  tags = local.common_tags
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-utilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "This metric monitors ec2 cpu utilization for scaling down"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  tags = local.common_tags
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
}