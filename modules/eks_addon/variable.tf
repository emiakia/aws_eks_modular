# EKS Cluster name where addons will be added
variable "eks_cluster_name" {
  description = "The name of the EKS cluster where the addon will be added"
  type        = string
}

# Addon name to be used
variable "addon_name" {
  description = "The name of the addon to be created"
  type        = string
}

# Addon version
variable "addon_version" {
  description = "The version of the addon to be created"
  type        = string
}
