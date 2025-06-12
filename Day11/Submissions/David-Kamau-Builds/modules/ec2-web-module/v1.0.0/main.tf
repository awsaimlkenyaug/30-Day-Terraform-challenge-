# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Using count to conditionally create resources
resource "aws_instance" "this" {
  count = var.enabled ? 1 : 0
  
  ami                         = data.aws_ami.amazon_linux2.id
  instance_type               = "t2.micro"  # Free Tier eligible
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true

  tags = {
    for key, value in {
      Name        = "${var.name_prefix}-${var.environment}"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Version     = "1.0.0"
    } : key => value
  }
}