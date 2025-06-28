variable "deployment_mode" {
  description = "Controls whether resources are actually deployed. Set to 'test' to prevent resource creation and costs"
  type        = string
  default     = "test"
  validation {
    condition     = contains(["test", "deploy"], var.deployment_mode)
    error_message = "deployment_mode must be either 'test' or 'deploy'"
  }
}