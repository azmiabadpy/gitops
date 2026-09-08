variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS"
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

variable "rds_security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}