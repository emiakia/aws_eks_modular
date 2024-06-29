provider "aws" {
  region = "eu-central-1" # Replace with your desired region
}

# Data source to get specific VPC
data "aws_vpc" "specified_vpc" {
  id = "vpc-0cc7e1e8d0e236d78"
}

# Data source to get VPC subnets
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.specified_vpc.id]
  }
}

# IAM Role for EKS Cluster
module "iam_role_eks_cluster" {
  source                = "./modules/iam_role"
  iam_role_description = var.iam_role_description
  iam_role_name         = var.iam_role_name
  assume_role_service   = var.assume_role_service
  policy_version        = var.policy_version
  policy_action         = var.policy_action
  policy_effect         = var.policy_effect
}

# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eksClusterRole"
#   description = "Amazon EKS - Cluster role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# Attach policies to the EKS Cluster Role
module "iam_role_policy_attachment_eks_cluster_policy" {
  source      = "./modules/iam_role_policy_attachment"
  policy_arn  = var.eks_cluster_policy_arn
  role_name   = module.iam_role_eks_cluster.iam_role_name
}

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role     = module.iam_role_eks_cluster.iam_role_name
# }
module "iam_role_policy_attachment_eks_vpc_policy" {
  source      = "./modules/iam_role_policy_attachment"
  policy_arn  = var.vpc_policy_arn
  role_name   = module.iam_role_eks_cluster.iam_role_name
}

# resource "aws_iam_role_policy_attachment" "eks_vpc_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role     = module.iam_role_eks_cluster.iam_role_name
# }

# IAM Role for Node Group
module "iam_role_node_group" {
  source                = "./modules/iam_role"
  iam_role_name         = var.iam_role_ng_name
  iam_role_description = var.iam_role_ng_description
  assume_role_service   = var.ng_assume_role_service
  policy_version        = var.ng_policy_version
  policy_action         = var.ng_policy_action
  policy_effect         = var.ng_policy_effect
}

# resource "aws_iam_role" "eks_node_group_role" {
#   name = "EKSNodeGroupRole"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# Attach policies to the EKS Node Group Role
module "iam_role_policy_attachment_eks_node_group_policy" {
  for_each = toset([
    "AmazonEC2ContainerRegistryReadOnly",
    "AmazonEKS_CNI_Policy",
    "AmazonEKSWorkerNodePolicy"
  ])
  source      = "./modules/iam_role_policy_attachment"
  policy_arn  = "arn:aws:iam::aws:policy/${each.value}"
  role_name   = module.iam_role_eks_cluster.iam_role_name
}

# resource "aws_iam_role_policy_attachment" "node_group_policies" {
#   for_each = toset([
#     "AmazonEC2ContainerRegistryReadOnly",
#     "AmazonEKS_CNI_Policy",
#     "AmazonEKSWorkerNodePolicy"
#   ])
  
#   policy_arn = "arn:aws:iam::aws:policy/${each.value}"
#   role     = module.iam_role_eks_cluster.iam_role_name
# }

# EKS Cluster
module "eks_cluster" {
  source                = "./modules/eks_cluster"
  eks_name              = var.eks_name
  eks_version           = var.eks_version
  eks_role_arn          = module.iam_role_eks_cluster.iam_role_arn
  eks_subnet_ids        = data.aws_subnets.subnets.ids
  eks_security_group_ids = [module.security_group.sg_id]
  
  eks_depends_on = [
    module.iam_role_policy_attachment_eks_cluster_policy,
    module.iam_role_policy_attachment_eks_vpc_policy
  ]
}

# resource "aws_eks_cluster" "terraform_eks" {
#   name     = "terraformEKS"
#   role_arn  = module.iam_role_eks_cluster.iam_role_arn
#   version   = "1.30"
  
#   vpc_config {
#     subnet_ids = data.aws_subnets.subnets.ids
#     security_group_ids = [aws_security_group.default.id]
#     endpoint_public_access = true
#   }

#   depends_on = [
#     module.iam_role_policy_attachment_eks_cluster_policy,
#     module.iam_role_policy_attachment_eks_vpc_policy
#   ]
# }

# Node Group
module "eks_node_group" {
  source                 = "./modules/eks_node_group"
  eks_ng_cluster_name    = module.eks_cluster.eks_cluster_name
  eks_ng_node_group_name = var.eks_ng_node_group_name
  eks_ng_node_role_arn   = module.iam_role_node_group.iam_role_arn
  eks_ng_subnet_ids      = data.aws_subnets.subnets.ids
  eks_ng_desired_size    = var.eks_ng_desired_size
  eks_ng_min_size        = var.eks_ng_min_size
  eks_ng_max_size        = var.eks_ng_max_size
  eks_ng_instance_types  = var.eks_ng_instance_types
  eks_ng_disk_size       = var.eks_ng_disk_size
  eks_ng_ami_type        = var.eks_ng_ami_type
  eks_ng_max_unavailable = var.eks_ng_max_unavailable
  depends_on = [module.iam_role_policy_attachment_eks_node_group_policy]
}

# resource "aws_eks_node_group" "terraform_eks_node_group" {
#   cluster_name    = module.eks_cluster.eks_cluster_name
#   node_group_name = "terraformEKSNodeGroup"
#   node_role_arn   = module.iam_role_node_group.iam_role_arn 
#   subnet_ids      = data.aws_subnets.subnets.ids
#   scaling_config {
#     desired_size = 2
#     min_size     = 2
#     max_size     = 2
#   }
#   instance_types = ["t2.micro"]
#   disk_size      = 10
#   ami_type       = "AL2_x86_64"

#   update_config {
#     max_unavailable = 1
#   }

#   depends_on = [
#     module.iam_role_policy_attachment_eks_node_group_policy
#   ]
# }

# Security Group for EKS Nodes (default security group)
module "security_group" {
  source          = "./modules/security_group"
  sg_vpc_id       = data.aws_vpc.specified_vpc.id
}

# resource "aws_security_group" "default" {
#   vpc_id = data.aws_vpc.specified_vpc.id
# }

# EKS Add-ons
# module "eks_addon_coredns" {
#   source          = "./modules/eks_addon"
#   eks_cluster_name = module.eks_cluster.eks_cluster_name
#   addon_name       = var.eks_addon_coredns_addon_name 
#   addon_version    = var.eks_addon_coredns_addon_version 
# }
# resource "aws_eks_addon" "coredns" {
#   cluster_name = module.eks_cluster.eks_cluster_name
#   addon_name   = "coredns"
#   addon_version = "v1.11.1-eksbuild.8"
# }

# module "eks_addon_kube_proxy" {
#   source          = "./modules/eks_addon"
#   eks_cluster_name = module.eks_cluster.eks_cluster_name
#   addon_name       = var.eks_addon_kube_proxy_addon_name 
#   addon_version    = var.eks_addon_kube_proxy_addon_version 
# }
# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name = module.eks_cluster.eks_cluster_name
#   addon_name   = "kube-proxy"
#   addon_version = "v1.30.0-eksbuild.3"
# }
