# Domain name for the Route53 Hosted Zone (e.g., example.com)
variable "zone_name" {
  description = "The domain name for the Route53 hosted zone"
  type        = string
}

# TTL (Time-To-Live) for all records
variable "ttl" {
  description = "The TTL (in seconds) for the DNS records"
  type        = number
  default     = 300  # 5 minutes
}

# Common tags to apply to all resources
variable "common_tags" {
  description = "Common tags to apply to all Route53 resources"
  type        = map(string)
}

# ------------------------------
# Variables for ALB Record
# ------------------------------

variable "record_name_alb" {
  description = "Subdomain for ALB record (e.g., 'app')"
  type        = string
}

variable "record_type_alb" {
  description = "Record type for ALB (e.g., 'A' or 'CNAME')"
  type        = string
}

variable "record_value_alb" {
  description = "DNS name of the ALB (e.g., module.elb.alb_dns_name)"
  type        = string
}

# ------------------------------
# Variables for EC2 Record
# ------------------------------

variable "record_name_ec2" {
  description = "Subdomain for EC2 record (e.g., 'ec2')"
  type        = string
}

variable "record_type_ec2" {
  description = "Record type for EC2 (e.g., 'A')"
  type        = string
}

variable "record_value_ec2" {
  description = "Public IP or DNS of the EC2 instance"
  type        = string
}

