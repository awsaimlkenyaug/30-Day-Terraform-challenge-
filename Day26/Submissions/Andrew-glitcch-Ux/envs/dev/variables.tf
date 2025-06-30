
variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}



# ========== Shared Variables ==========
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance or launch template"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# ========== ASG Module ==========
variable "launch_template_name" {
  description = "Prefix for the launch template name"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
}

# ========== EC2 Module ==========
variable "security_group_id" {
  description = "ID of the security group to attach to EC2"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

# ========== ALB Module ==========
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group for the ALB"
  type        = string
}

variable "target_group_port" {
  description = "Port the target group forwards to"
  type        = number
}

# ========== VPC Module ==========
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "public_subnet_cidr_1" {
  type        = string
  description = "CIDR block for first public subnet"
}

variable "public_subnet_name_1" {
  type        = string
  description = "Name tag for first public subnet"
}

variable "availability_zone_1" {
  type        = string
  description = "Availability zone for first public subnet"
}


variable "public_subnet_cidr_2" {
  type        = string
  description = "CIDR block for second public subnet"
}

variable "public_subnet_name_2" {
  type        = string
  description = "Name tag for second public subnet"
}

variable "availability_zone_2" {
  type        = string
  description = "Availability zone for second public subnet"
}


variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

# ========== Security Group ==========
variable "security_group_name" {
  description = "Name tag for the security group"
  type        = string
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
}

variable "sg_ingress_description" {
  description = "Description for the ingress rule"
  type        = string
}

variable "sg_ingress_from_port" {
  description = "Ingress rule from port"
  type        = number
}

variable "sg_ingress_to_port" {
  description = "Ingress rule to port"
  type        = number
}

variable "sg_ingress_protocol" {
  description = "Ingress rule protocol (e.g. tcp)"
  type        = string
}

variable "sg_ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
}
