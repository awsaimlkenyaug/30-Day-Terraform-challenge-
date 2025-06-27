# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux2.id
  instance_type               = "t2.micro"                 # Free Tier
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  
  # Enhanced security features in v1.1.0
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"  # IMDSv2 required
  }
  
  # Improved EBS encryption in v1.1.0
  root_block_device {
    encrypted = true
    volume_size = 10
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Version     = "1.1.0"
  }
}