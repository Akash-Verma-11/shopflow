provider "aws" { region = var.aws_region }

module "vpc" {
  source       = "../../modules/vpc"
  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source            = "../../modules/iam"
  project_name      = var.project_name
  environment       = var.environment
  eks_cluster_name  = "${var.project_name}-${var.environment}"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
}

module "eks" {
  source               = "../../modules/eks"
  project_name         = var.project_name
  environment          = var.environment
  private_subnet_ids   = module.vpc.private_subnet_ids
  public_subnet_ids    = module.vpc.public_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_nodes_role_arn    = module.iam.eks_nodes_role_arn
  cluster_sg_id         = module.vpc.eks_cluster_sg_id
  node_sg_id             = module.vpc.eks_nodes_sg_id
}

module "rds" {
  source              = "../../modules/rds"
  project_name        = var.project_name
  environment         = var.environment
  private_subnet_ids  = module.vpc.private_subnet_ids
  rds_sg_id           = module.vpc.rds_sg_id
  db_password         = var.db_password
}
