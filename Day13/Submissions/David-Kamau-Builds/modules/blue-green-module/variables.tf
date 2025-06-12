variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
  validation {
    condition     = contains(["dev","staging","prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB and instances"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach"
  type        = list(string)
}

variable "ssh_key_name" {
  description = "Name of EC2 key pair for SSH access"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch in the active environment"
  type        = number
  default     = 2
}

variable "active_deployment" {
  description = "Which deployment is currently active: blue or green"
  type        = string
  default     = "blue"
  validation {
    condition     = contains(["blue", "green"], var.active_deployment)
    error_message = "active_deployment must be either 'blue' or 'green'"
  }
}

variable "blue_version" {
  description = "Version tag for blue environment"
  type        = string
  default     = "1.0.0"
}

variable "green_version" {
  description = "Version tag for green environment"
  type        = string
  default     = "1.0.1"
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile for accessing secrets"
  type        = string
  default     = null
}

variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region where resources are deployed"
  type        = string
  default     = "us-east-1"
}