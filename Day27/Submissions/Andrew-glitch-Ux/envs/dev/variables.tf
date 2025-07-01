variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

# ---------------- VPC Variables ----------------
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the internet gateway"
  type        = string
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_name_1" {
  description = "Name tag for the first public subnet"
  type        = string
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "public_subnet_name_2" {
  description = "Name tag for the second public subnet"
  type        = string
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_name_1" {
  description = "Name tag for the first private subnet"
  type        = string
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "private_subnet_name_2" {
  description = "Name tag for the second private subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "First availability zone"
  type        = string
}

variable "availability_zone_2" {
  description = "Second availability zone"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "private_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
}

variable "nat_eip_name" {
  description = "Name tag for the NAT gateway EIP"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT gateway"
  type        = string
}

# ---------------- EC2 Variables ----------------
variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

# ---------------- ASG / Launch Template ----------------
variable "launch_template_name" {
  description = "Name of the EC2 launch template"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "min_size" {
  description = "Minimum number of ASG instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of ASG instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of ASG instances"
  type        = number
}

# ---------------- ALB Variables ----------------
variable "alb_name" {
  description = "Name tag for the ALB"
  type        = string
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

# ---------------- Security Group ----------------
variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
}

variable "sg_ingress_description" {
  description = "Ingress rule description"
  type        = string
}

variable "sg_ingress_from_port" {
  description = "Ingress from port"
  type        = number
}

variable "sg_ingress_to_port" {
  description = "Ingress to port"
  type        = number
}

variable "sg_ingress_protocol" {
  description = "Ingress rule protocol"
  type        = string
}

variable "sg_ingress_cidr_blocks" {
  description = "List of CIDR blocks for ingress"
  type        = list(string)
}



variable "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  type        = string
}

variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine type (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "RDS instance type (e.g., db.t3.micro)"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size in GB"
  type        = number
}

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "db_username" {
  description = "Master username for the DB"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the DB"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Whether to enable multi-AZ deployment"
  type        = bool
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
}

variable "zone_name" {
  description = "The domain name for the hosted zone"
  type        = string
}

variable "ttl" {
  description = "Time to live (TTL) for the DNS records"
  type        = number
}


# ALB record
variable "record_name_alb" {
  description = "Subdomain for ALB record (e.g., 'app')"
  type        = string
}

variable "record_type_alb" {
  description = "Record type for ALB (e.g., 'CNAME')"
  type        = string
}

# EC2 record
variable "record_name_ec2" {
  description = "Subdomain for EC2 record (e.g., 'ec2')"
  type        = string
}

variable "record_type_ec2" {
  description = "Record type for EC2 (e.g., 'A')"
  type        = string
}


variable "source_bucket_name" {
  description = "Name of the source S3 bucket"
  type        = string
}

variable "destination_bucket_name" {
  description = "Name of the destination S3 bucket"
  type        = string
}

variable "replication_role_name" {
  description = "IAM Role name used for replication"
  type        = string
}

variable "replication_rule_id" {
  description = "ID to identify the replication rule"
  type        = string
}

variable "replication_storage_class" {
  description = "Storage class for replicated objects (e.g., STANDARD, STANDARD_IA)"
  type        = string
}

variable "common_tags" {
  description = "Map of common tags to apply to all resources"
  type        = map(string)
}

