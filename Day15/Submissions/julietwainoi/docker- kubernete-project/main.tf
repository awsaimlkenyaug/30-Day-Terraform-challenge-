module "network" {
  source         = "./modules/network"
  vpc_name       = "eks-vpc"
  vpc_cidr       = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}




module "eks_infra" {
  source          = "./modules/eks"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.29"
  vpc_id          = module.network.vpc_id
  subnet_ids      = module.network.subnet_ids
  environment     = "dev"
}

module "k8s-deployment" {
  source = "./modules/k8s-deployment"

  app_name       = "my-app"
  image          = "${aws_ecr_repository.app_repo.repository_url}:latest"
  container_port = 3000

}

