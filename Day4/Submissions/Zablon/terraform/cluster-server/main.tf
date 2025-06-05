# configure the  provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# get the default vpc
data "aws_vpc" "default" {
  default = true
}

# fetch all subnets in the default VPC
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# get AMI 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# create a security group 
resource "aws_security_group" "sg" {
  name = "alb-security-group"

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
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

# define a target group 
resource "aws_lb_target_group" "lb_target_group" {
  name     = "target-group"
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# create the application load balancer 
resource "aws_lb" "load_balancer" {
  name               = "alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default_subnets.ids
  security_groups    = [aws_security_group.sg.id]
}

# create a listener on the alb to listen for http requests
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# listener rule to forward all http requests to the target group
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

# define a launch template for instance 
resource "aws_launch_template" "template" {
  name_prefix   = "launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.http_port} &
  EOF
  )

  vpc_security_group_ids = [aws_security_group.sg.id]
}

# create an auto scaling group
resource "aws_autoscaling_group" "auto_scaling" {
  vpc_zone_identifier = data.aws_subnets.default_subnets.ids
  target_group_arns   = [aws_lb_target_group.lb_target_group.arn]
  health_check_type   = "ELB"
  min_size            = 2
  max_size            = 4

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "WebServer"
    propagate_at_launch = true
  }
}
