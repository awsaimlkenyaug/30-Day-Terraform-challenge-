resource "aws_lb" "this" {
  name               = "${var.name_prefix}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  # Enable deletion protection
  enable_deletion_protection = true

  # Enable access logging
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "alb-logs"
    enabled = true
  }

  # Enable dropping invalid HTTP headers
  drop_invalid_header_fields = true

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-alb"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# S3 bucket for ALB access logs
resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.name_prefix}-${var.environment}-alb-logs"

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-alb-logs"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Block public access to the logs bucket
resource "aws_s3_bucket_public_access_block" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 bucket policy to allow ALB to write logs
resource "aws_s3_bucket_policy" "lb_logs" {
  bucket = aws_s3_bucket.lb_logs.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_elb_service_account.main.id}:root"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.lb_logs.arn}/alb-logs/AWSLogs/*"
      }
    ]
  })
}

# Get the AWS ELB service account for the current region
data "aws_elb_service_account" "main" {}

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
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = var.certificate_arn != null ? 1 : 0
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.active_deployment == "blue" ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
  }
}

resource "aws_lb_listener_rule" "test_traffic" {
  count        = var.certificate_arn != null ? 1 : 0
  listener_arn = aws_lb_listener.https[0].arn
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

resource "aws_launch_template" "blue" {
  name_prefix            = "${var.name_prefix}-${var.environment}-blue"
  image_id               = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids

  dynamic "iam_instance_profile" {
    for_each = var.instance_profile_name != null ? [1] : []
    content {
      name = var.instance_profile_name
    }
  }

  user_data = base64encode(templatefile("${path.module}/templates/user_data.sh.tpl", {
    environment = "blue"
    version     = var.blue_version
    secret_name = var.secret_name
    region      = var.region
  }))

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

resource "aws_launch_template" "green" {
  name_prefix            = "${var.name_prefix}-${var.environment}-green"
  image_id               = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids

  dynamic "iam_instance_profile" {
    for_each = var.instance_profile_name != null ? [1] : []
    content {
      name = var.instance_profile_name
    }
  }

  user_data = base64encode(templatefile("${path.module}/templates/user_data.sh.tpl", {
    environment = "green"
    version     = var.green_version
    secret_name = var.secret_name
    region      = var.region
  }))

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

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}