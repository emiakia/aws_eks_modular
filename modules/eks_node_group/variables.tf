variable "eks_ng_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_ng_node_group_name" {
  description = "Name of the EKS Node Group"
  type        = string
}

variable "eks_ng_node_role_arn" {
  description = "IAM role ARN for the EKS Node Group"
  type        = string
}

variable "eks_ng_subnet_ids" {
  description = "List of subnet IDs for the EKS Node Group"
  type        = list(string)
}

variable "eks_ng_desired_size" {
  description = "Desired number of nodes in the EKS Node Group"
  type        = number
}

variable "eks_ng_min_size" {
  description = "Minimum number of nodes in the EKS Node Group"
  type        = number
}

variable "eks_ng_max_size" {
  description = "Maximum number of nodes in the EKS Node Group"
  type        = number
}

variable "eks_ng_instance_types" {
  description = "Instance types for the EKS Node Group"
  type        = list(string)
}

variable "eks_ng_disk_size" {
  description = "Disk size for each node in the EKS Node Group (in GB)"
  type        = number
}

variable "eks_ng_ami_type" {
  description = "AMI type for the EKS Node Group"
  type        = string
}

variable "eks_ng_max_unavailable" {
  description = "Maximum number of nodes unavailable during update"
  type        = number
}

variable "eks_ng_depends_on" {
  description = "Dependencies for the EKS Node Group"
  type        = list(any)
  default     = []
}
