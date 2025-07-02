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
  sg_name        = "${var.name_prefix}-sg"
  
  # Conditional SSH access based on environment
  ssh_cidr_blocks = {
    dev        = ["0.0.0.0/0"]
    staging    = ["10.0.0.0/8", "172.16.0.0/12"]
    production = ["10.0.0.0/8"]
  }
  
  # Conditional monitoring ports based on environment
  enable_monitoring_ports = var.environment != "dev"
}

resource "aws_security_group" "web" {
  name        = local.sg_name
  description = "Security group for ${var.environment} web server"

  # HTTP access - always allowed
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access - always allowed
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access - conditional based on environment
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = lookup(local.ssh_cidr_blocks, var.environment, ["0.0.0.0/0"])
  }
  
  # Monitoring ports - conditional based on environment
  dynamic "ingress" {
    for_each = local.enable_monitoring_ports ? [1] : []
    content {
      description = "Monitoring"
      from_port   = 9100
      to_port     = 9100
      protocol    = "tcp"
      cidr_blocks = var.environment == "production" ? ["10.0.0.0/8"] : ["0.0.0.0/0"]
    }
  }
  
  # Additional ports for production environment
  dynamic "ingress" {
    for_each = var.environment == "production" ? [1] : []
    content {
      description = "Application specific port"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }

  # Docker daemon port for container management (if needed)
  dynamic "ingress" {
    for_each = var.environment == "production" ? [1] : []
    content {
      description = "Docker daemon"
      from_port   = 2376
      to_port     = 2376
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }

  # Outbound traffic - always allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name          = local.sg_name
    Module        = "security_group"
    ModuleVersion = local.module_version
  })
}