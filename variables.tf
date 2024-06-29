variable "iam_role_name" {
  description = "The name of the IAM role."
  type        = string
  default     = "eksClusterRole"
}

variable "iam_role_description" {
  description = "The description of the role."
  type        = string
  default     = "Amazon EKS - Cluster role"
}

variable "assume_role_service" {
  description = "The service that assumes the IAM role."
  type        = string
  default     = "eks.amazonaws.com"
}

variable "policy_version" {
  description = "The version of the policy."
  type        = string
  default     = "2012-10-17"
}

variable "policy_action" {
  description = "The action allowed by the policy."
  type        = string
  default     = "sts:AssumeRole"
}

variable "policy_effect" {
  description = "The effect of the policy."
  type        = string
  default     = "Allow"
}

####################################
variable "iam_role_ng_name" {
  description = "The name of the IAM role."
  type        = string
  default     = "EKSNodeGroupRole"
}

variable "iam_role_ng_description" {
  description = "The description of the role."
  type        = string
  default     = "Amazon EKS - Cluster role"
}

variable "ng_assume_role_service" {
  description = "The service that assumes the IAM role."
  type        = string
  default     = "ec2.amazonaws.com"
}

variable "ng_policy_version" {
  description = "The version of the policy."
  type        = string
  default     = "2012-10-17"
}

variable "ng_policy_action" {
  description = "The action allowed by the policy."
  type        = string
  default     = "sts:AssumeRole"
}

variable "ng_policy_effect" {
  description = "The effect of the policy."
  type        = string
  default     = "Allow"
}

variable "eks_cluster_policy_arn" {
  description = "The ARN of the IAM policy to attach to the role."
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
variable "vpc_policy_arn" {
  description = "The ARN of the IAM policy to attach to the role."
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

#EKS Module
variable "eks_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "terraformEKS"
}

variable "eks_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "eks_ng_node_group_name" {
  description = "Name of the EKS Node Group"
  type        = string
  default     = "terraformEKSNodeGroup"
}

variable "eks_ng_desired_size" {
  description = "Desired number of nodes in the EKS Node Group"
  type        = number
  default     = 2
}

variable "eks_ng_min_size" {
  description = "Minimum number of nodes in the EKS Node Group"
  type        = number
  default     = 2
}

variable "eks_ng_max_size" {
  description = "Maximum number of nodes in the EKS Node Group"
  type        = number
  default     = 2
}

variable "eks_ng_instance_types" {
  description = "Instance types for the EKS Node Group"
  type        = list(string)
  default     = ["t2.micro"]
}

variable "eks_ng_disk_size" {
  description = "Disk size for each node in the EKS Node Group (in GB)"
  type        = number
  default     = 10
}

variable "eks_ng_ami_type" {
  description = "AMI type for the EKS Node Group"
  type        = string
  default     = "AL2_x86_64"
}

variable "eks_ng_max_unavailable" {
  description = "Maximum number of nodes unavailable during update"
  type        = number
  default     = 1
}

# # VPC ID where the Security Group will be created
# variable "sg_vpc_id" {
#   description = "The ID of the VPC where the security group will be created"
#   type        = string
# }

# EKS Cluster name where addons will be added
# variable "eks_cluster_name" {
#   description = "The name of the EKS cluster where the addon will be added"
#   type        = string
# }

# Addon name to be used
variable "eks_addon_coredns_addon_name" {
  description = "The name of the addon to be created"
  type        = string
  default     = "coredns"
}

# Addon version
variable "eks_addon_coredns_addon_version" {
  description = "The version of the addon to be created"
  type        = string
  default     = "v1.11.1-eksbuild.8"
}

variable "eks_addon_kube_proxy_addon_name" {
  description = "The name of the addon to be created"
  type        = string
  default     = "kube-proxy"
}

# Addon version
variable "eks_addon_kube_proxy_addon_version" {
  description = "The version of the addon to be created"
  type        = string
  default     = "v1.30.0-eksbuild.3"
}
