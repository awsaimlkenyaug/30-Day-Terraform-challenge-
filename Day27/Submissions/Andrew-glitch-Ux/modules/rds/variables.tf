variable "db_identifier" {
  description = "Unique name for the RDS instance"
  type        = string
}

variable "engine" {
  description = "The database engine to use (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage (in GB) to allocate"
  type        = number
}

variable "db_name" {
  description = "The name of the initial database to create"
  type        = string
}

variable "username" {
  description = "Master username for the database"
  type        = string
}

variable "password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Enable Multi-AZ deployments for high availability"
  type        = bool
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
}

variable "db_subnet_group_name" {
  description = "Name for the DB subnet group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where the RDS instance will be deployed"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to attach to the RDS instance"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}
