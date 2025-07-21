output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "ec2_security_group_id" {
  value = module.ec2.security_group_id
}


output "rds_endpoint" {
  value       = var.create_rds ? module.rds[0].endpoint : ""
  description = "RDS endpoint if created"
}

output "rds_port" {
  value       = var.create_rds ? module.rds[0].port : 0
  description = "RDS port if created"
}

output "rds_username" {
  value       = var.create_rds ? module.rds[0].username : ""
  description = "RDS username if created"
}

output "generated_rds_password" {
  value     = random_password.rds_password.result
  sensitive = true
}


output "security_group_id" {
  value = module.ec2.security_group_id  # ✅ Correct way
}



output "cdn_bucket_name" {
  value       = var.create_s3_cdn ? module.s3_cdn[0].bucket_name : ""
  description = "S3 CDN bucket name if created"
}
output "rds_secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.arn
}

output "rds_password" {
  value     = random_password.rds_password.result
  sensitive = true
}

