resource "aws_launch_template" "this" {
  name_prefix   = "${var.app_name}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    app_name = var.app_name
  }))

  vpc_security_group_ids = [var.instance_sg_id]

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
  resource_type = "instance"

  tags = {
    Name = "${var.app_name}-lt"
  }
}

}

resource "aws_autoscaling_group" "this" {
  name                      = "${var.app_name}-asg"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 30

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "${var.app_name}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "asg_sg" {
  name        = "${var.app_name}-asg-sg"
  description = "Allow SSH and HTTP for ASG"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress_cidr_blocks
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.http_ingress_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }
}


