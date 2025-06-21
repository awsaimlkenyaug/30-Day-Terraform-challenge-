variable "name" {
  type = string
  validation {
    condition     = length(var.name) > 0
    error_message = "ASG name must not be empty."
  }
}

variable "ami_id" {
  type = string
  validation {
    condition     = can(regex("^ami-[a-zA-Z0-9]+$", var.ami_id))
    error_message = "The AMI ID must start with 'ami-' and contain alphanumeric characters."
  }
}

variable "instance_type" {
  type = string
  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Only t3.micro, t3.small, or t3.medium are allowed."
  }
}

variable "key_name" {
  type = string
  validation {
    condition     = length(var.key_name) > 0
    error_message = "Key name cannot be empty."
  }
}

variable "security_group_ids" {
  type = list(string)
  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "At least one security group ID must be provided."
  }
}

variable "subnet_ids" {
  type = list(string)
  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "At least one subnet ID must be specified."
  }
}

variable "desired_capacity" {
  type = number
  validation {
    condition     = var.desired_capacity >= 1
    error_message = "Desired capacity must be at least 1."
  }
}

variable "max_size" {
  type = number
  validation {
    condition     = var.max_size >= 1
    error_message = "Max size must be at least 1."
  }
}

variable "min_size" {
  type = number
  validation {
    condition     = var.min_size >= 0
    error_message = "Min size must be 0 or more."
  }
}

variable "tags" {
  type = map(string)
}

variable "alb_target_group_arn" {
  type = string
  validation {
    condition     = can(regex("^arn:aws:elasticloadbalancing", var.alb_target_group_arn))
    error_message = "Must be a valid ALB Target Group ARN."
  }
}
