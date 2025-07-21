resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.name_prefix}-db"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  #name                    = var.dbname
  username                = var.username
  password                = var.password
  #password = random_password.rds_password.result

  db_subnet_group_name    = aws_db_subnet_group.this.name
  #vpc_security_group_ids  = [var.security_group_id]
  vpc_security_group_ids  = [var.security_group_id]         # ✅ Correct

  skip_final_snapshot     = true
  publicly_accessible     = var.publicly_accessible
  deletion_protection     = false

  tags = {
    Name = "${var.name_prefix}-rds"
  }
}










 