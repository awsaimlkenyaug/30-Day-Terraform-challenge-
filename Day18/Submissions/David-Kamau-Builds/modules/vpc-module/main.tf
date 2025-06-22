# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-vpc"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# KMS key for encryption
resource "aws_kms_key" "log_group_key" {
  description             = "KMS key for VPC flow logs encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-vpc-flow-logs-key"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# VPC Flow Logs
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flowlogs/${var.name_prefix}-${var.environment}"
  retention_in_days = 365 # Changed to 365 days
  kms_key_id        = aws_kms_key.log_group_key.arn

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-vpc-flow-logs"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role" "vpc_flow_logs" {
  name = "${var.name_prefix}-${var.environment}-vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "vpc_flow_logs" {
  name = "${var.name_prefix}-${var.environment}-vpc-flow-logs-policy"
  role = aws_iam_role.vpc_flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_cloudwatch_log_group.vpc_flow_logs.arn}:*"
        ]
      }
    ]
  })
}

resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.vpc_flow_logs.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-vpc-flow-log"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false # Changed to false for security

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-public-${count.index + 1}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-igw"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-public-rt"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Security Groups
resource "aws_security_group" "web" {
  name        = "${var.name_prefix}-${var.environment}-web-sg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow HTTP from specified CIDR blocks"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow HTTPS from specified CIDR blocks"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Allow SSH from trusted network"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_egress_cidr_blocks
    description = "Allow specified outbound traffic"
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-web-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-${var.environment}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow HTTP from specified CIDR blocks"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow HTTPS from specified CIDR blocks"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_egress_cidr_blocks
    description = "Allow specified outbound traffic"
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-alb-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# WAF association with ALB
resource "aws_wafv2_web_acl_association" "alb" {
  resource_arn = var.alb_arn
  web_acl_arn  = var.waf_web_acl_arn
}

# Secure default security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  # Remove all default rules
  ingress = []
  egress  = []

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-default-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}