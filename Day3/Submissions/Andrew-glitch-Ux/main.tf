provider "aws" {
  region = var.aws_region
}
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = lookup(
    {
      private_subnet_1 = "eu-north-1a"
      private_subnet_2 = "eu-north-1b"
    },
    each.key,
    "eu-north-1a"
  )

  tags = {
    Name = each.key
  }
}
#######################################
# 2. Allocate Elastic IP for NAT Gateway
#######################################
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
##################################
# 3. Create NAT Gateway
##################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id           # Attach Elastic IP created above
  subnet_id     = var.public_subnet_ids["public_subnet_A"]  # Public subnet where NAT lives

  tags = {
    Name = "NATGateway"
  }

  depends_on = [aws_eip.nat_eip]  # Ensure EIP is created before NAT Gateway
}
##########################################
# 4. Create Route Table for Private Subnets
##########################################
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id  

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}
###########################################
# 5. Associate Private Subnets with Route Table
###########################################
resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_s3_bucket" "my-new-S3-bucket" {   
  bucket = "my-new-tf-test-bucket-andre-${random_id.randomness.hex}"  
  tags = {     
    Name    = "My S3 Bucket"     
    Purpose = "Intro to Resource Blocks Lab"   
  } 
}
resource "aws_s3_bucket_ownership_controls" "my_new_bucket_acl" {   
  bucket = aws_s3_bucket.my-new-S3-bucket.id  
  rule {     
    object_ownership = "BucketOwnerPreferred"   
  }
}
resource "aws_security_group" "my-new-security-group" {
  name        = "web_server_inbound"
  description = "Allow inbound traffic on tcp/443"
  vpc_id      = var.vpc_id  
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow 443 from the Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "web_server_inbound"
    Purpose = "Intro to Resource Blocks Lab"
  }
}
resource "random_id" "randomness" {
  byte_length = 16
}
resource "aws_instance" "web_server" {
  ami                    = "ami-0c1ac8a41498c1a9c"  # Ubuntu 22.04 for eu-north-1 (Stockholm)
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_ids["public_subnet_A"]  # choose public subnet
  vpc_security_group_ids = [aws_security_group.my-new-security-group.id]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Day3WebServer"
  }

  depends_on = [aws_nat_gateway.nat]
}
