variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "enable_access_logs" {
  description = "Enable access logs for the load balancer"
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "S3 bucket for access logs"
  type        = string
  default     = null
}

variable "access_logs_prefix" {
  description = "S3 prefix for access logs"
  type        = string
  default     = null
}

# Target Group variables
variable "target_group_port" {
  description = "Port on which the target group receives traffic"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol to use for routing traffic to the targets"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Type of target that you must specify when registering targets"
  type        = string
  default     = "instance"
}

# Health Check variables
variable "health_check_enabled" {
  description = "Whether health checks are enabled"
  type        = bool
  default     = true
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health checks successes required"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures required"
  type        = number
  default     = 2
}

variable "health_check_timeout" {
  description = "Amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Approximate amount of time, in seconds, between health checks"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Destination for the health check request"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port to use to connect with the target for health checking"
  type        = string
  default     = "traffic-port"
}

variable "health_check_protocol" {
  description = "Protocol to use to connect with the target for health checking"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "Response codes to use when checking for a healthy responses from a target"
  type        = string
  default     = "200"
}

# Stickiness variables
variable "stickiness_enabled" {
  description = "Whether target stickiness is enabled"
  type        = bool
  default     = false
}

variable "stickiness_type" {
  description = "Type of stickiness"
  type        = string
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "Time period, in seconds, during which requests from a client should be routed to the same target"
  type        = number
  default     = 86400
}

# Listener variables
variable "listener_port" {
  description = "Port on which the load balancer is listening"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol for connections from clients to the load balancer"
  type        = string
  default     = "HTTP"
}

variable "ssl_policy" {
  description = "Name of the SSL Policy for the listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "certificate_arn" {
  description = "ARN of the default SSL server certificate"
  type        = string
  default     = null
}

variable "enable_https_redirect" {
  description = "Enable HTTP to HTTPS redirect"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
