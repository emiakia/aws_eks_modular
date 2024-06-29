variable "eks_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "eks_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "eks_subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "eks_security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}

variable "eks_depends_on" {
  description = "Dependencies for the EKS cluster"
  type        = list(any)
  default     = []
}
