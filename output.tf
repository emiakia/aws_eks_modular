output "iam_role_id" {
  description = "The ID of the IAM role."
  value       = module.iam_role_eks_cluster.iam_role_id
}

output "iam_role_name" {
  description = "The name of the IAM role."
  value       = module.iam_role_eks_cluster.iam_role_name
}

output "iam_role_arn" {
  description = "The ARN of the IAM role."
  value       = module.iam_role_eks_cluster.iam_role_arn
}


output "iam_role_ng_id" {
  description = "The ID of the IAM role."
  value       = module.iam_role_node_group.iam_role_id
}

output "iam_role_ng_name" {
  description = "The name of the IAM role."
  value       = module.iam_role_node_group.iam_role_name
}

output "iam_role_ng_arn" {
  description = "The ARN of the IAM role."
  value       = module.iam_role_node_group.iam_role_arn
}

# output "role_policy_attachment_id" {
#   description = "The ID of the IAM role policy attachment."
#   value       = module.iam_role_policy_attachment.role_policy_attachment_id
# }
output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks_cluster.eks_cluster_id
}

output "eks_cluster_arn" {
  description = "EKS Cluster ARN"
  value       = module.eks_cluster.eks_cluster_arn
}

output "eks_cluster_name" {
  description = "EKS Cluster NAME"
  value       = module.eks_cluster.eks_cluster_name
}

output "eks_node_group_id" {
  description = "EKS Node Group ID"
  value       = module.eks_node_group.eks_node_group_id
}

output "eks_node_group_arn" {
  description = "EKS Node Group ARN"
  value       = module.eks_node_group.eks_node_group_arn
}

output "sg_id" {
  description = "The ID of the created security group"
  value       = module.security_group.sg_id
}

# output "coredns_addon_arn" {
#   description = "The ARN of the CoreDNS EKS addon"
#   value       = module.eks_addon_coredns.addon_arn
# }

# output "kube_proxy_addon_arn" {
#   description = "The ARN of the Kube Proxy EKS addon"
#   value       = module.eks_addon_kube_proxy.addon_arn
# }
