output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.mysql.id
}

output "db_host" {
  description = "RDS MySQL hostname"
  value       = aws_db_instance.mysql.address
}

output "db_port" {
  description = "RDS MySQL port"
  value       = aws_db_instance.mysql.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.mysql.db_name
}