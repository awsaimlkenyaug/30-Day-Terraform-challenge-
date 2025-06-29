// filepath: ../../modules/ec2/main.tf
variable "ami_id" {}
variable "instance_type" {}
variable "name" {}
variable "subnet_id" {}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = var.name
  }
}