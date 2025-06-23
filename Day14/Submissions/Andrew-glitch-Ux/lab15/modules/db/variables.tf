variable "engine" {
  description = "Database engine"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance class/type"
  type        = string
}

variable "name" {
  description = "DB name"
  type        = string
}

variable "username" {
  description = "DB username"
  type        = string
}

variable "password" {
  description = "DB password"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Database port"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}
variable "allocated_storage" {
  description = "Storage size for RDS in GB"
  type        = number
}

variable "environment" {
  description = "Environment for tagging or naming"
  type        = string
}

