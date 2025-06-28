resource "aws_lb" "this" {
  name               = "${var.name_prefix}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-alb"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_lb_target_group" "blue" {
  name     = "${var.name_prefix}-${var.environment}-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-blue-tg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Deployment  = "blue"
  }
}

resource "aws_lb_target_group" "green" {
  name     = "${var.name_prefix}-${var.environment}-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-green-tg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Deployment  = "green"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.active_deployment == "blue" ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
  }
}

# Test traffic listener rule for canary testing
resource "aws_lb_listener_rule" "test_traffic" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = var.active_deployment == "blue" ? aws_lb_target_group.green.arn : aws_lb_target_group.blue.arn
  }

  condition {
    http_header {
      http_header_name = "X-Environment"
      values           = ["test"]
    }
  }
}

# Launch template for blue environment
resource "aws_launch_template" "blue" {
  name_prefix            = "${var.name_prefix}-${var.environment}-blue"
  image_id               = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>This is BLUE environment</h1><p>Version: ${var.blue_version}</p></body></html>" > /var/www/html/index.html
  EOF
  )
  
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
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
      Name        = "${var.name_prefix}-${var.environment}-blue"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Deployment  = "blue"
      Version     = var.blue_version
    }
  }
}

# Launch template for green environment
resource "aws_launch_template" "green" {
  name_prefix            = "${var.name_prefix}-${var.environment}-green"
  image_id               = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>This is GREEN environment</h1><p>Version: ${var.green_version}</p></body></html>" > /var/www/html/index.html
  EOF
  )
  
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
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
      Name        = "${var.name_prefix}-${var.environment}-green"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Deployment  = "green"
      Version     = var.green_version
    }
  }
}

# Auto Scaling Group for blue environment
resource "aws_autoscaling_group" "blue" {
  name                = "${var.name_prefix}-${var.environment}-blue-asg"
  desired_capacity    = var.active_deployment == "blue" ? var.instance_count : 0
  min_size            = var.active_deployment == "blue" ? 1 : 0
  max_size            = var.active_deployment == "blue" ? 3 : 0
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [aws_lb_target_group.blue.arn]
  
  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }
  
  dynamic "tag" {
    for_each = {
      Name        = "${var.name_prefix}-${var.environment}-blue"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Deployment  = "blue"
      Version     = var.blue_version
    }
    
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# Auto Scaling Group for green environment
resource "aws_autoscaling_group" "green" {
  name                = "${var.name_prefix}-${var.environment}-green-asg"
  desired_capacity    = var.active_deployment == "green" ? var.instance_count : 0
  min_size            = var.active_deployment == "green" ? 1 : 0
  max_size            = var.active_deployment == "green" ? 3 : 0
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [aws_lb_target_group.green.arn]
  
  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }
  
  dynamic "tag" {
    for_each = {
      Name        = "${var.name_prefix}-${var.environment}-green"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Deployment  = "green"
      Version     = var.green_version
    }
    
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}