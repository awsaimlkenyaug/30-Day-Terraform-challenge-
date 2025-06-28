# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Auto Scaling Group for v2.0.0
resource "aws_launch_template" "this" {
  name_prefix            = "${var.name_prefix}-${var.environment}"
  image_id               = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids
  
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"  # IMDSv2 required
  }
  
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted   = true
      volume_size = 10
    }
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.name_prefix}-${var.environment}"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Version     = "2.0.0"
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "${var.name_prefix}-${var.environment}-asg"
  desired_capacity    = var.instance_count
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = [var.subnet_id]
  
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  
  dynamic "tag" {
    for_each = {
      Name        = "${var.name_prefix}-${var.environment}"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Version     = "2.0.0"
    }
    
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# CloudWatch monitoring for v2.0.0
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = var.enable_monitoring ? 1 : 0
  
  alarm_name          = "${var.name_prefix}-${var.environment}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
  
  alarm_actions = []
}