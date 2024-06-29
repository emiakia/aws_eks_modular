output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_arn" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_name" {
  description = "EKS Cluster NAME"
  value       = aws_eks_cluster.eks_cluster.name
}
