variable "launch_template_name" {
  description = "Name prefix for the launch template"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Initial desired number of instances in the ASG"
  type        = number
}

variable "subnet_id" {
  description = "Public subnet ID"
  type        = string
}


variable "target_group_arns" {
  description = "List of target group ARNs to associate with the ASG"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
