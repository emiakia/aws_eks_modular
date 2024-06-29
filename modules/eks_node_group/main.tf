resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eks_ng_cluster_name
  node_group_name = var.eks_ng_node_group_name
  node_role_arn   = var.eks_ng_node_role_arn
  subnet_ids      = var.eks_ng_subnet_ids

  scaling_config {
    desired_size = var.eks_ng_desired_size
    min_size     = var.eks_ng_min_size
    max_size     = var.eks_ng_max_size
  }

  instance_types = var.eks_ng_instance_types
  disk_size      = var.eks_ng_disk_size
  ami_type       = var.eks_ng_ami_type

  update_config {
    max_unavailable = var.eks_ng_max_unavailable
  }

  depends_on = [var.eks_ng_depends_on]
}
