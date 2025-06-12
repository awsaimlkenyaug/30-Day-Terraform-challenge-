# East Coast Region Resources (us-east-1)
resource "aws_vpc" "east" {
  provider             = aws.east
  cidr_block           = "10.42.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name        = "dkb-${var.environment}-vpc-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

resource "aws_subnet" "east_public" {
  provider                = aws.east
  count                   = 2
  vpc_id                  = aws_vpc.east.id
  cidr_block              = cidrsubnet("10.42.0.0/16", 8, count.index)
  availability_zone       = element(["us-east-1a", "us-east-1c"], count.index)
  map_public_ip_on_launch = true
  
  tags = {
    Name        = "dkb-${var.environment}-public-${count.index + 1}-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

resource "aws_internet_gateway" "east" {
  provider = aws.east
  vpc_id   = aws_vpc.east.id
  
  tags = {
    Name        = "dkb-${var.environment}-igw-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

resource "aws_route_table" "east_public" {
  provider = aws.east
  vpc_id   = aws_vpc.east.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.east.id
  }
  
  tags = {
    Name        = "dkb-${var.environment}-public-rt-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

resource "aws_route_table_association" "east_public" {
  provider       = aws.east
  count          = 2
  subnet_id      = aws_subnet.east_public[count.index].id
  route_table_id = aws_route_table.east_public.id
}

resource "aws_security_group" "east_web" {
  provider    = aws.east
  name        = "dkb-${var.environment}-web-sg-east"
  description = "Security group for web servers in East Coast region"
  vpc_id      = aws_vpc.east.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
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
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name        = "dkb-${var.environment}-web-sg-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

resource "aws_security_group" "east_alb" {
  provider    = aws.east
  name        = "dkb-${var.environment}-alb-sg-east"
  description = "Security group for ALB in East Coast region"
  vpc_id      = aws_vpc.east.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name        = "dkb-${var.environment}-alb-sg-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}

# West Coast Region Resources (us-west-2)
resource "aws_vpc" "west" {
  provider             = aws.west
  cidr_block           = "10.87.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name        = "dkb-${var.environment}-vpc-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
  }
}

resource "aws_subnet" "west_public" {
  provider                = aws.west
  count                   = 2
  vpc_id                  = aws_vpc.west.id
  cidr_block              = cidrsubnet("10.87.0.0/16", 8, count.index)
  availability_zone       = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = true
  
  tags = {
    Name        = "dkb-${var.environment}-public-${count.index + 1}-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
  }
}

resource "aws_internet_gateway" "west" {
  provider = aws.west
  vpc_id   = aws_vpc.west.id
  
  tags = {
    Name        = "dkb-${var.environment}-igw-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
  }
}

resource "aws_route_table" "west_public" {
  provider = aws.west
  vpc_id   = aws_vpc.west.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.west.id
  }
  
  tags = {
    Name        = "dkb-${var.environment}-public-rt-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
  }
}

resource "aws_route_table_association" "west_public" {
  provider       = aws.west
  count          = 2
  subnet_id      = aws_subnet.west_public[count.index].id
  route_table_id = aws_route_table.west_public.id
}

resource "aws_security_group" "west_web" {
  provider    = aws.west
  name        = "dkb-${var.environment}-web-sg-west"
  description = "Security group for web servers in West Coast region"
  vpc_id      = aws_vpc.west.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
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
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name        = "dkb-${var.environment}-web-sg-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
  }
}

resource "aws_security_group" "west_alb" {
  provider    = aws.west
  name        = "dkb-${var.environment}-alb-sg-west"
  description = "Security group for ALB in West Coast region"
  vpc_id      = aws_vpc.west.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name        = "dkb-${var.environment}-alb-sg-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
  }
}

# Blue-Green deployment module for East Coast region
module "east_deployment" {
  source             = "../modules/blue-green-module"
  name_prefix        = "dkb-east"
  environment        = var.environment
  vpc_id             = aws_vpc.east.id
  subnet_ids         = aws_subnet.east_public[*].id
  security_group_ids = [aws_security_group.east_web.id]
  ssh_key_name       = "dkb-east-key"
  instance_count     = var.instance_count
  active_deployment  = var.active_deployment
  blue_version       = "2.1.0"
  green_version      = "2.2.0"
  
  instance_profile_name = module.east_secrets.instance_profile_name
  secret_name           = module.east_secrets.secret_name
  region                = "us-east-1"
  
  providers = {
    aws = aws.east
  }
}

# Blue-Green deployment module for West Coast region
module "west_deployment" {
  source             = "../modules/blue-green-module"
  name_prefix        = "dkb-west"
  environment        = var.environment
  vpc_id             = aws_vpc.west.id
  subnet_ids         = aws_subnet.west_public[*].id
  security_group_ids = [aws_security_group.west_web.id]
  ssh_key_name       = "dkb-west-key"
  instance_count     = var.instance_count
  active_deployment  = var.active_deployment
  blue_version       = "2.1.0"
  green_version      = "2.2.0"
  
  instance_profile_name = module.west_secrets.instance_profile_name
  secret_name           = module.west_secrets.secret_name
  region                = "us-west-2"
  
  providers = {
    aws = aws.west
  }
}

# Outputs for East Coast region
output "east_alb_dns_name" {
  description = "DNS name of the load balancer in East Coast region"
  value       = module.east_deployment.alb_dns_name
}

output "east_active_deployment" {
  description = "Currently active deployment in East Coast region (blue or green)"
  value       = module.east_deployment.active_deployment
}

output "east_active_version" {
  description = "Version of the currently active deployment in East Coast region"
  value       = module.east_deployment.active_version
}

# Outputs for West Coast region
output "west_alb_dns_name" {
  description = "DNS name of the load balancer in West Coast region"
  value       = module.west_deployment.alb_dns_name
}

output "west_active_deployment" {
  description = "Currently active deployment in West Coast region (blue or green)"
  value       = module.west_deployment.active_deployment
}

output "west_active_version" {
  description = "Version of the currently active deployment in West Coast region"
  value       = module.west_deployment.active_version
}