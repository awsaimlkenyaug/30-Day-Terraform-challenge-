variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the web and ALB resources"
  type        = list(string)
}

variable "allowed_egress_cidr_blocks" {
  description = "List of CIDR blocks allowed for egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Can be overridden for stricter security
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer for WAF association"
  type        = string
}

variable "waf_web_acl_arn" {
  description = "ARN of the WAF Web ACL to associate with the ALB"
  type        = string
}