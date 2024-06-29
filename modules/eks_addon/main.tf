resource "aws_eks_addon" "addon" {
  cluster_name = var.eks_cluster_name
  addon_name   = var.addon_name
  addon_version = var.addon_version
}
