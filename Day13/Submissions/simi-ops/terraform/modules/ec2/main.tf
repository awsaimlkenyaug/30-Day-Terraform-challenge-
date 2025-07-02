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
  instance_name  = "${var.name_prefix}-instance"
  
  # Calculate number of instances based on environment
  instance_count = var.environment == "production" ? 3 : (var.environment == "staging" ? 2 : 1)
  
  # Conditional monitoring based on environment
  enable_detailed_monitoring = var.environment == "production" ? true : false
  
  # Conditional root volume size based on environment
  root_volume_size = var.environment == "production" ? 50 : (var.environment == "staging" ? 30 : 20)
}

resource "aws_instance" "web" {
  count         = local.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  
  vpc_security_group_ids = [var.security_group_id]
  monitoring             = local.enable_detailed_monitoring
  
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = var.environment
    instance_id = count.index + 1
  }))
  
  root_block_device {
    volume_size = local.root_volume_size
    volume_type = var.environment == "production" ? "gp3" : "gp2"
    encrypted   = var.environment == "production" ? true : false
    tags = merge(var.tags, {
      Name = "${local.instance_name}-${count.index + 1}-root"
    })
  }
  
  tags = merge(var.tags, {
    Name          = "${local.instance_name}-${count.index + 1}"
    Module        = "ec2"
    ModuleVersion = local.module_version
  })

  # Conditional deployment of additional EBS volume for production and staging
  dynamic "ebs_block_device" {
    for_each = var.environment != "dev" ? [1] : []
    content {
      device_name = "/dev/xvdf"
      volume_size = var.environment == "production" ? 100 : 50
      volume_type = var.environment == "production" ? "gp3" : "gp2"
      encrypted   = var.environment == "production" ? true : false
      tags = merge(var.tags, {
        Name = "${local.instance_name}-${count.index + 1}-data"
      })
    }
  }
}