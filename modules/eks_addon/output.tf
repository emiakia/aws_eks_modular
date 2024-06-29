output "addon_arn" {
  description = "The ARN of the created EKS addon"
  value       = aws_eks_addon.addon.arn
}

output "addon_name" {
  description = "The name of the EKS addon"
  value       = aws_eks_addon.addon.addon_name
}
