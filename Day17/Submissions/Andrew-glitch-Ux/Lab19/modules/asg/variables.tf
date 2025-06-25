variable "name" {
  description = "Name of the ASG resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "user_data" {
  description = "User data for launching EC2 instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for ASG"
  type        = list(string)
}


variable "health_check_grace_period" {
  description = "Health check grace period in seconds"
  type        = number
}

variable "target_group_arns" {
  description = "List of Target Group ARNs for load balancer"
  type        = list(string)
}

variable "tags" {
  description = "Common tags for ASG"
  type        = map(string)
}



variable "asg_security_group_ids" {
  type        = list(string)
  description = "Security group IDs to attach to EC2 instances in the ASG"
}


