resource "aws_instance" "ec2" {
  count         = length(var.instances)
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instances[count.index]
  }
}
