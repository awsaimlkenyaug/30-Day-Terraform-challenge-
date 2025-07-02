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
  alb_name       = "${var.name_prefix}-alb"
  tg_name        = "${var.name_prefix}-tg"
  
  # Conditional health check settings based on environment
  health_check_interval = var.environment == "production" ? 15 : 30
  health_check_timeout  = var.environment == "production" ? 10 : 5
  health_check_path     = var.environment == "production" ? "/health" : "/"
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

resource "aws_lb" "web" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = data.aws_subnets.default.ids

  # Conditional deletion protection based on environment
  enable_deletion_protection = var.environment == "production"

  # Conditional idle timeout based on environment
  idle_timeout = var.environment == "production" ? 300 : 60



  tags = merge(var.tags, {
    Name          = local.alb_name
    Module        = "alb"
    ModuleVersion = local.module_version
  })
}

resource "aws_lb_target_group" "web" {
  name     = local.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  # Conditional target group settings based on environment
  deregistration_delay = var.environment == "production" ? 300 : 60

  # Conditional stickiness based on environment or parameter
  dynamic "stickiness" {
    for_each = var.enable_stickiness ? [1] : []
    content {
      type            = "lb_cookie"
      cookie_duration = 86400
      enabled         = true
    }
  }

  health_check {
    enabled             = true
    healthy_threshold   = var.environment == "production" ? 3 : 2
    interval            = local.health_check_interval
    matcher             = "200"
    path                = local.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = local.health_check_timeout
    unhealthy_threshold = var.environment == "production" ? 3 : 2
  }

  tags = merge(var.tags, {
    Name          = local.tg_name
    Module        = "alb"
    ModuleVersion = local.module_version
  })
}

# Target group attachments are handled by ASG
# No manual attachments needed

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

