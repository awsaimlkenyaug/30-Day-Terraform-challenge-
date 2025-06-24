variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
}

variable "active_env" {
  description = "The currently active environment: blue or green"
  type        = string
  default     = "blue"
}
