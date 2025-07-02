data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "security_group" {
  source = "./modules/security_group"

  environment = var.environment
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

# Auto Scaling Group deployment
module "asg" {
  source            = "./modules/asg"
  environment       = var.environment
  name_prefix       = local.name_prefix
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = local.instance_config[var.environment].instance_type
  security_group_id = module.security_group.security_group_id
  min_size          = local.instance_config[var.environment].min_size
  max_size          = local.instance_config[var.environment].max_size
  desired_capacity  = local.instance_config[var.environment].min_size
  target_group_arns = local.deploy_alb ? [module.alb[0].target_group_arn] : []
  tags              = local.common_tags

  depends_on = [module.alb]
}

# Conditional ALB deployment
module "alb" {
  count = local.deploy_alb ? 1 : 0

  source            = "./modules/alb"
  environment       = var.environment
  name_prefix       = local.name_prefix
  security_group_id = module.security_group.security_group_id
  instance_ids      = []
  tags              = local.common_tags
  enable_stickiness = var.environment == "production"
}





