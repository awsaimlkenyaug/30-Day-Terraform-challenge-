variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "index_document" {
  description = "Index document for static site"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document for static site"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}
