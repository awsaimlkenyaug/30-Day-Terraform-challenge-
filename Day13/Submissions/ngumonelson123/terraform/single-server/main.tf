provider "aws" {
  region = "us-east-1"
}

######################
# 🔐 Fetch Secret
######################

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "MyDBPassword"
}

######################
# 🛜 Networking - VPC
######################

resource "aws_vpc" "custom" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "CustomVPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "MainIGW"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

######################
# 🧱 EC2 Instance
######################

resource "aws_instance" "web" {
  ami                         = "ami-0fc5d935ebf8bc3bc"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true

  tags = {
    Name = "WebServer"
  }
}

######################
# 🔐 Output
######################

output "db_password" {
  value     = data.aws_secretsmanager_secret_version.db_password.secret_string
  sensitive = true
}
