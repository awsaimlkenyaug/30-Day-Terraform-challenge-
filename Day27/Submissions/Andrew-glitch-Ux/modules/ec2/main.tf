resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id                    # 💬 Comes from VPC module's output: public_subnet_id
  vpc_security_group_ids = [var.security_group_id]

         

  tags = merge(
    var.common_tags,
    {
      Name = var.instance_name
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
