variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "eks_cluster_security_group_id" {
  description = "EKS cluster security group ID allowed to access RDS"
  type        = string
}