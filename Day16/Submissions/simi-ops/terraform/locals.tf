locals {
  name_prefix = "${var.environment}-web"

  common_tags = merge(var.tags, {
    Environment   = var.environment
    ManagedBy     = "terraform"
    Project       = "30-day-terraform-challenge"
    ModuleVersion = "2.0.0"
    CreatedBy     = "simi-ops"
    Repository    = "30-Day-Terraform-challenge"
  })

  # Conditional deployment flags
  deploy_alb        = var.environment != "dev" || var.force_alb_in_dev
  deploy_monitoring = var.environment != "dev"
  deploy_backup     = var.environment == "production"
  
  # Environment-specific configurations
  instance_config = {
    dev = {
      instance_type = "t3.micro"
      min_size      = 1
      max_size      = 2
      volume_size   = 20
      encrypted     = false
      monitoring    = false
    }
    staging = {
      instance_type = "t3.small"
      min_size      = 2
      max_size      = 4
      volume_size   = 30
      encrypted     = false
      monitoring    = false
    }
    production = {
      instance_type = "t3.medium"
      min_size      = 3
      max_size      = 6
      volume_size   = 50
      encrypted     = true
      monitoring    = true
    }
  }
}