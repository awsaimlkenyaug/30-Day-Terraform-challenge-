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

  enable_deletion_protection = var.environment == "production"

  # dynamic "access_logs" {
  #   for_each = var.environment != "dev" ? [1] : []
  #   content {
  #     bucket  = "simi-ops-my-alb-logs${var.environment}"
  #     prefix  = "alb-logs"
  #     enabled = true
  #   }
  # }

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

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = merge(var.tags, {
    Name          = local.tg_name
    Module        = "alb"
    ModuleVersion = local.module_version
  })
}

resource "aws_lb_target_group_attachment" "web" {
  count = length(var.instance_ids)

  target_group_arn = aws_lb_target_group.web.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
