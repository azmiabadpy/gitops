terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}


module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_groups" {
  source = "./modules/security-groups"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

#module "rds" {

  #source = "./modules/rds"

  #project_name = var.project_name

  #private_subnet_ids = module.vpc.private_subnet_ids

  #database_name     = var.database_name
  #database_username = var.database_username
  #database_password = var.database_password


  #rds_security_group_id = module.security_groups.rds_security_group_id
#}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
}

# module "iam" {
#   source = "./modules/iam"

#   project_name = var.project_name
# }

module "vpc_endpoints" {
  source = "./modules/vpc-endpoints"

  project_name = var.project_name

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  private_route_table_ids = [
    module.vpc.private_route_table_id
  ]
}

# module "eks" {
#   source = "./modules/eks"

#   project_name = var.project_name

#   vpc_id = module.vpc.vpc_id

#   private_subnet_ids = module.vpc.private_subnet_ids

#   eks_cluster_role_arn = module.iam.eks_cluster_role_arn

#   eks_node_role_arn = module.iam.eks_node_role_arn

#   node_instance_type = var.node_instance_type
# }

