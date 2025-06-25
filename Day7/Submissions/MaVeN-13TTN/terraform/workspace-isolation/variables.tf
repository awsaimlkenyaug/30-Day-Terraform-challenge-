variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-workspace-isolation"
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    Project   = "30-Day-Terraform-Challenge"
    Day       = "7"
    Owner     = "MaVeN-13TTN"
    Challenge = "State-Isolation"
  }
}
