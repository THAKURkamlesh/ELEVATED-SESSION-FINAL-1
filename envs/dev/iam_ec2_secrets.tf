resource "aws_iam_role" "ec2_secrets_role" {
  name = "${var.name_prefix}-${var.env}-ec2-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "secrets_read_policy" {
  name = "${var.name_prefix}-${var.env}-read-rds-secret"
  description = "Allow EC2 to read RDS secret from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["secretsmanager:GetSecretValue"],
        Resource = aws_secretsmanager_secret.rds_secret.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.secrets_read_policy.arn
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name_prefix}-${var.env}-ec2-profile"
  role = aws_iam_role.ec2_secrets_role.name
}
