output "eks_node_group_id" {
  description = "EKS Node Group ID"
  value       = aws_eks_node_group.eks_node_group.id
}

output "eks_node_group_arn" {
  description = "EKS Node Group ARN"
  value       = aws_eks_node_group.eks_node_group.arn
}
