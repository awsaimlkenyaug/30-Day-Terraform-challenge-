variable "region" {}
variable "instance_name" {}

provider "aws" {
  alias  = "modregion"
  region = var.region
}

# Get latest Amazon Linux 2 AMI
data "aws_ssm_parameter" "ami" {
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  provider = aws.modregion
}

# Create a minimal VPC
resource "aws_vpc" "main" {
  provider   = aws.modregion
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.instance_name}-vpc"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "main" {
  provider          = aws.modregion
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.instance_name}-subnet"
  }
}

# Create a basic security group
resource "aws_security_group" "instance_sg" {
  provider = aws.modregion
  name     = "${var.instance_name}-sg"
  vpc_id   = aws_vpc.main.id

  ingress {
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
    Name = "${var.instance_name}-sg"
  }
}

# Launch the EC2 instance
resource "aws_instance" "vm" {
  provider          = aws.modregion
  ami               = data.aws_ssm_parameter.ami.value
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = var.instance_name
  }
}
