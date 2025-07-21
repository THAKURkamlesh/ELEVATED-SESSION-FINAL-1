# 🔐 Generate random password for RDS
resource "random_password" "rds_password" {
   length           = 16
  special          = true
  upper            = true
  lower            = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}

# 🔐 Create the secret container in Secrets Manager
resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "${var.name_prefix}-${var.env}-rds-secret"
  description = "RDS credentials for ${var.env}"
}

# 💾 Store the username and random password inside the secret
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.rds_password.result
  })
}
#resource "random_password" "rds_password" {
 

