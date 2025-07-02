terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  module_version = "1.0.0"
  asg_name       = "${var.name_prefix}-asg"
  lt_name        = "${var.name_prefix}-lt"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_launch_template" "web" {
  name_prefix   = "${local.lt_name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  
  vpc_security_group_ids = [var.security_group_id]
  
  monitoring {
    enabled = var.environment == "production"
  }
  
  user_data = base64encode(templatefile("${path.module}/../ec2/user_data.sh", {
    environment = var.environment
    instance_id = "asg"
  }))

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.environment == "production" ? 50 : (var.environment == "staging" ? 30 : 20)
      volume_type = var.environment == "production" ? "gp3" : "gp2"
      encrypted   = var.environment == "production"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name          = "${local.asg_name}-instance"
      Module        = "asg"
      ModuleVersion = local.module_version
    })
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name                = local.asg_name
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = data.aws_subnets.default.ids
  target_group_arns   = var.target_group_arns
  health_check_type   = length(var.target_group_arns) > 0 ? "ELB" : "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.environment == "production" ? 90 : 50
      instance_warmup       = 300
    }
  }

  tag {
    key                 = "Name"
    value               = local.asg_name
    propagate_at_launch = false
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = false
    }
  }

  tag {
    key                 = "Module"
    value               = "asg"
    propagate_at_launch = false
  }

  tag {
    key                 = "ModuleVersion"
    value               = local.module_version
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${local.asg_name}-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${local.asg_name}-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${local.asg_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.environment == "production" ? 70 : 80
  alarm_description   = "Scale up on high CPU"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${local.asg_name}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "Scale down on low CPU"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }
}