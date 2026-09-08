resource "aws_db_subnet_group" "this" {

  name = "${var.project_name}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}


resource "aws_db_instance" "mysql" {

  identifier = "${var.project_name}-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password

  port = 3306

  db_subnet_group_name = aws_db_subnet_group.this.name

  # Attach RDS Security Group
  vpc_security_group_ids = [
    var.rds_security_group_id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-mysql"
  }
}