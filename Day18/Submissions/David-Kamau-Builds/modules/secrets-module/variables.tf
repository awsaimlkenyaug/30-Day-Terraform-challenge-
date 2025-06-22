variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod"
  }
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret"
  type        = number
  default     = 7
}

variable "secret_values" {
  description = "Map of secret key/value pairs to store in Secrets Manager"
  type        = map(string)
  sensitive   = true
}
variable "enable_rotation" {
  description = "Enable automatic rotation for secrets"
  type        = bool
  default     = false
}

variable "rotation_days" {
  description = "Number of days between automatic rotations"
  type        = number
  default     = 30
}