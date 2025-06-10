# Enhanced Load Balancer Infrastructure
# Day 5: Scaling Infrastructure & State Management
# Building upon Day 4's clustered web server architecture

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state configuration (to be implemented)
  # backend "s3" {
  #   bucket = "terraform-state-bucket-name"
  #   key    = "day5/enhanced-load-balancer/terraform.tfstate"
  #   region = "us-east-1"
  #   encrypt = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.default_tags
  }
}

# Data sources for dynamic infrastructure discovery
data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-name"
    values = var.availability_zones
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = data.aws_availability_zones.available.names
  }
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

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

# Local values for computed configurations
locals {
  default_tags = {
    Project     = "30-day-terraform-challenge"
    Day         = "5"
    Environment = var.environment
    Owner       = "MaVeN-13TTN"
    CreatedBy   = "Terraform"
    Type        = "enhanced-load-balancer"
  }

  cluster_name = "${var.environment}-day5-enhanced-cluster"

  # Advanced scaling configuration
  scaling_config = {
    target_tracking = {
      cpu_target         = var.cpu_target_percentage
      scale_out_cooldown = var.scale_out_cooldown
      scale_in_cooldown  = var.scale_in_cooldown
    }
    step_scaling = {
      high_cpu_threshold = var.high_cpu_threshold
      low_cpu_threshold  = var.low_cpu_threshold
    }
  }
}

# Security Groups
resource "aws_security_group" "alb" {
  name_prefix = "${local.cluster_name}-alb-"
  vpc_id      = data.aws_vpc.default.id
  description = "Security group for Application Load Balancer"

  # HTTP access
  dynamic "ingress" {
    for_each = var.enable_http ? [1] : []
    content {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  # HTTPS access
  dynamic "ingress" {
    for_each = var.enable_https ? [1] : []
    content {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-alb-security-group"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instances" {
  name_prefix = "${local.cluster_name}-instances-"
  vpc_id      = data.aws_vpc.default.id
  description = "Security group for web server instances"

  # HTTP from ALB
  ingress {
    description     = "HTTP from ALB"
    from_port       = var.server_port
    to_port         = var.server_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # SSH access (conditional)
  dynamic "ingress" {
    for_each = var.enable_ssh ? [1] : []
    content {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_cidr_blocks
    }
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-instances-security-group"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Launch Template for instances
resource "aws_launch_template" "web_servers" {
  name_prefix   = "${local.cluster_name}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.instances.id]

  # Enhanced user data with monitoring and logging
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_port       = var.server_port
    server_text       = var.server_text
    enable_monitoring = var.enable_detailed_monitoring
    cluster_name      = local.cluster_name
  }))

  # Enhanced monitoring
  monitoring {
    enabled = var.enable_detailed_monitoring
  }

  # Block device mappings with encryption
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type           = var.ebs_volume_type
      volume_size           = var.ebs_volume_size
      delete_on_termination = true
      encrypted             = var.enable_ebs_encryption
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.default_tags, {
      Name = "${local.cluster_name}-instance"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.default_tags, {
      Name = "${local.cluster_name}-volume"
    })
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-launch-template"
  })
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = substr("${local.cluster_name}-alb", 0, 32)
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection = var.enable_deletion_protection

  # Access logs (optional)
  dynamic "access_logs" {
    for_each = var.enable_access_logs ? [1] : []
    content {
      bucket  = var.access_logs_bucket
      prefix  = var.access_logs_prefix
      enabled = true
    }
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-alb"
  })
}

# Target Group with enhanced health checks
resource "aws_lb_target_group" "web_servers" {
  name     = substr("${local.cluster_name}-tg", 0, 32)
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  # Enhanced health check configuration
  health_check {
    enabled             = true
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    path                = var.health_check_path
    matcher             = var.health_check_matcher
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  # Stickiness configuration
  dynamic "stickiness" {
    for_each = var.enable_stickiness ? [1] : []
    content {
      type            = "lb_cookie"
      cookie_duration = var.stickiness_duration
      enabled         = true
    }
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-target-group"
  })
}

# ALB Listener for HTTP
resource "aws_lb_listener" "web_servers_http" {
  count             = var.enable_http ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = var.enable_https && var.redirect_http_to_https ? "redirect" : "forward"

    dynamic "redirect" {
      for_each = var.enable_https && var.redirect_http_to_https ? [1] : []
      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    dynamic "forward" {
      for_each = var.enable_https && var.redirect_http_to_https ? [] : [1]
      content {
        target_group {
          arn = aws_lb_target_group.web_servers.arn
        }
      }
    }
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-http-listener"
  })
}

# ALB Listener for HTTPS (conditional)
resource "aws_lb_listener" "web_servers_https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers.arn
  }

  tags = merge(local.default_tags, {
    Name = "${local.cluster_name}-https-listener"
  })
}

# Auto Scaling Group with enhanced configuration
resource "aws_autoscaling_group" "web_servers" {
  name                      = "${local.cluster_name}-asg"
  vpc_zone_identifier       = data.aws_subnets.default.ids
  target_group_arns         = [aws_lb_target_group.web_servers.arn]
  health_check_type         = "ELB"
  health_check_grace_period = var.health_check_grace_period

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  # Advanced termination policies
  termination_policies = var.termination_policies

  launch_template {
    id      = aws_launch_template.web_servers.id
    version = "$Latest"
  }

  # Instance refresh configuration
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup        = 300
    }
  }

  # Advanced tags
  dynamic "tag" {
    for_each = merge(local.default_tags, {
      Name = "${local.cluster_name}-asg-instance"
    })
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = "${local.cluster_name}-asg"
    propagate_at_launch = false
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}

# Target Tracking Scaling Policy
resource "aws_autoscaling_policy" "target_tracking" {
  name                   = "${local.cluster_name}-target-tracking"
  scaling_adjustment     = null
  adjustment_type        = null
  cooldown               = null
  autoscaling_group_name = aws_autoscaling_group.web_servers.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = local.scaling_config.target_tracking.cpu_target
  }

  depends_on = [aws_autoscaling_group.web_servers]
}

# Step Scaling Policy - Scale Up
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${local.cluster_name}-scale-up"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.web_servers.name
  policy_type            = "StepScaling"

  step_adjustment {
    scaling_adjustment          = var.scale_up_adjustment
    metric_interval_lower_bound = 0
  }
}

# Step Scaling Policy - Scale Down
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${local.cluster_name}-scale-down"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.web_servers.name
  policy_type            = "StepScaling"

  step_adjustment {
    scaling_adjustment          = var.scale_down_adjustment
    metric_interval_upper_bound = 0
  }
}

# CloudWatch Alarms for Step Scaling
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${local.cluster_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.high_cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cloudwatch_alarm_period
  statistic           = "Average"
  threshold           = local.scaling_config.step_scaling.high_cpu_threshold
  alarm_description   = "This metric monitors high CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_servers.name
  }

  tags = local.default_tags
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${local.cluster_name}-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.low_cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cloudwatch_alarm_period
  statistic           = "Average"
  threshold           = local.scaling_config.step_scaling.low_cpu_threshold
  alarm_description   = "This metric monitors low CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_servers.name
  }

  tags = local.default_tags
}

# CloudWatch Alarm for ALB Target Health
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "${local.cluster_name}-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "This metric monitors unhealthy ALB targets"
  treat_missing_data  = "breaching"

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
    TargetGroup  = aws_lb_target_group.web_servers.arn_suffix
  }

  tags = local.default_tags
}
