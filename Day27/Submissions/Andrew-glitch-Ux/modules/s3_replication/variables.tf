variable "source_bucket_name" {
  description = "Name of the source S3 bucket for replication"
  type        = string
}

variable "destination_bucket_name" {
  description = "Name of the destination S3 bucket for replication"
  type        = string
}

variable "replication_role_name" {
  description = "Name of the IAM role used for S3 replication"
  type        = string
}

variable "replication_rule_id" {
  description = "ID for the S3 replication rule"
  type        = string
}

variable "replication_storage_class" {
  description = "Storage class to use for replicated objects (e.g., STANDARD, ONEZONE_IA)"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all created resources"
  type        = map(string)
  default     = {}
}
