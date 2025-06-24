# --------------------------------------------------
# GCP resources (commented out to avoid deployment)
# --------------------------------------------------

# resource "google_compute_network" "gcp_vpc" {
#   name                    = var.gcp_vpc_name
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "gcp_subnet" {
#   name          = var.gcp_subnet_name
#   ip_cidr_range = var.gcp_subnet_cidr
#   region        = var.gcp_region
#   network       = google_compute_network.gcp_vpc.id
# }

# --------------------------------------------------
# AWS resources (EKS + VPC + Subnets + IAM)
# --------------------------------------------------

resource "aws_vpc" "aws_vpc" {
  cidr_block = var.aws_vpc_cidr
  tags = {
    Name = var.aws_vpc_name
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.aws_subnet_cidr_1
  availability_zone       = var.aws_az_1
  map_public_ip_on_launch = true
  tags = {
    Name = var.aws_subnet_name_1
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.aws_subnet_cidr_2
  availability_zone       = var.aws_az_2
  map_public_ip_on_launch = true
  tags = {
    Name = var.aws_subnet_name_2
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = var.eks_cluster_policy_arn
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_a.id,
      aws_subnet.subnet_b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
}
