# ========== Provider ==========
variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

# ========== ALB ==========
variable "name" {
  description = "Name for the ALB"
  type        = string
}


variable "internal" {
  description = "Whether ALB is internal"
  type        = bool
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection on ALB"
  type        = bool
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for target group"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol for target group (HTTP/HTTPS)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB and other resources will be created"
  type        = string
}

variable "target_type" {
  description = "Target type (instance or ip)"
  type        = string
}

# Health check
variable "health_check_interval" {
  type        = number
  description = "Interval between health checks"
}

variable "health_check_path" {
  type        = string
  description = "Health check path"
}

variable "health_check_protocol" {
  type        = string
  description = "Health check protocol"
}

variable "health_check_timeout" {
  type        = number
  description = "Timeout for health check"
}

variable "healthy_threshold" {
  type        = number
  description = "Healthy threshold count"
}

variable "unhealthy_threshold" {
  type        = number
  description = "Unhealthy threshold count"
}

variable "health_check_matcher" {
  type        = string
  description = "Expected status code for health check"
}

# Listener
variable "listener_port" {
  type        = number
  description = "Listener port"
}

variable "listener_protocol" {
  type        = string
  description = "Listener protocol"
}

# ALB SG config
variable "alb_ingress_port" {
  type        = number
  description = "Port to allow ingress on ALB"
}

variable "alb_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to allow ingress on ALB"
}

variable "alb_egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to allow egress on ALB"
}

# ========== VPC ==========
variable "vpc_name" {
  description = "Base name for VPC and subnets"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames"
}

variable "public_subnets" {
  description = "Map of public subnets with CIDR and AZ"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

# ========== ASG ==========
variable "asg_name" {
  type        = string
  description = "Base name for ASG and Launch Template"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for EC2 instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "user_data" {
  type        = string
  description = "User data script"
}

variable "min_size" {
  type        = number
  description = "Minimum size of ASG"
}

variable "max_size" {
  type        = number
  description = "Maximum size of ASG"
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity of ASG"
}

variable "health_check_grace_period" {
  type        = number
  description = "Grace period for health checks in seconds"
}

# ========== Shared ==========
variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
