variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "database_name" {
  description = "MySQL database name"
  type        = string
}

variable "database_username" {
  description = "MySQL username"
  type        = string
  sensitive   = true
}

variable "database_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS managed nodes"
  type        = string

}