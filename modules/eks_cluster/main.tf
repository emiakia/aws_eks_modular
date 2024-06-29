resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_name
  role_arn = var.eks_role_arn
  version  = var.eks_version
  
  vpc_config {
    subnet_ids          = var.eks_subnet_ids
    security_group_ids  = var.eks_security_group_ids
    endpoint_public_access = true
  }

  depends_on = [var.eks_depends_on]
}


