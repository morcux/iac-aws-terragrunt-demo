resource "aws_db_subnet_group" "this" {
  name = "${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.environment}-db"
  engine = "postgres"
  engine_version = "15.0"
  instance_class = var.db_instance_class
  allocated_storage = 20
  storage_type = "gp2"
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot = true

  tags = {
    Name = "${var.environment}-db"
  }
}