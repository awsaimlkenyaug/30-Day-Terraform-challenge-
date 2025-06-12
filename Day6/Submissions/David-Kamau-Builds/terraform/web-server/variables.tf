variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name (used for tagging & naming)"
  type        = string
  default     = "day-6-test"
}

variable "certificate_arn" {
  description = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-ef56-7890-abcd-1234ef567890" //This is a dummy certificate ARN
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type for web servers (free tier eligible)"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for web server instances"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "key_pair_name" {
  description = "Name of your existing EC2 Key Pair for SSH access"
  type        = string
  default     = "web-server-key-pair"
}

variable "desired_capacity" {
  description = "Number of instances for the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 3
}