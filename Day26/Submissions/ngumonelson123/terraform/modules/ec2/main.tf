resource "aws_launch_template" "web" {
  name_prefix   = "web-launch-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = base64encode(file("${path.module}/user_data.sh"))
    lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "WebServer"
    }
  }
}
