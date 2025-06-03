variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "file-layout-isolation"
}

variable "application_name" {
  description = "Name of the application"
  type        = string
  default     = "web-app"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "Health check type for the Auto Scaling Group"
  type        = string
  default     = "ELB"
}

variable "health_check_grace_period" {
  description = "Health check grace period"
  type        = number
  default     = 300
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "enabled_metrics" {
  description = "List of CloudWatch metrics to enable for the Auto Scaling Group"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
}

variable "enable_autoscaling" {
  description = "Enable auto scaling policies and CloudWatch alarms"
  type        = bool
  default     = true
}

variable "cpu_high_threshold" {
  description = "CPU utilization threshold for scaling up"
  type        = number
  default     = 80
}

variable "cpu_low_threshold" {
  description = "CPU utilization threshold for scaling down"
  type        = number
  default     = 20
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
