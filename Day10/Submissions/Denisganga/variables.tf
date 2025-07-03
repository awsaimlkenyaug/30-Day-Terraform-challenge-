variable "enable_multi_region" {
  description = "Deploy to us-east-1 if true, otherwise eu-west-1"
  type        = bool
  default     = false
}

variable "deploy_ec2" {
  description = "Enable EC2 deployment"
  type        = bool
  default     = true
}

variable "deploy_s3" {
  description = "Enable S3 bucket deployment"
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 2
}

variable "bucket_names" {
  description = "List of S3 bucket base names"
  type        = set(string)
  default     = ["bucket-one", "bucket-two"]
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"
}
variable "ami_map" {
  description = "Mapping of regions to their AMI IDs"
  type        = map(string)
  default = {
    "us-east-1" = "ami-0c02fb55956c7d316"   
    "eu-west-1" = "ami-0767046d1677be5a0"   
  }
}

