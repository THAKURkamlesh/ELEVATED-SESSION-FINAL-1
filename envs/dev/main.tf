provider "aws" {
  region  = var.region
  profile = var.profile
}

module "ec2" {
  source           = "../../modules/ec2"
  key_name         = var.key_name
  public_key_path  = var.public_key_path
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_id        = var.subnet_id
  vpc_id           = var.vpc_id
  name_prefix      = var.name_prefix
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name  
  env                  = var.env 
}

module "sg_rds" {
  source                = "../../modules/security-group-rds"
  name_prefix           = var.name_prefix
  vpc_id                = var.vpc_id
  ec2_security_group_id = module.ec2.security_group_id  # <--- pass EC2 SG here

  count = var.create_rds ? 1 : 0
}


module "rds" {
  source                 = "../../modules/rds"
  name_prefix            = var.name_prefix
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  #username               = var.db_username
  #password               = var.db_password
  subnet_ids             = var.db_subnet_ids
 security_group_id = var.create_rds ? module.sg_rds[0].rds_security_group_id : null
  publicly_accessible    = var.db_publicly_accessible
  # Pass username and password from Secrets Manager
  username = var.db_username
  password = random_password.rds_password.result  



  count = var.create_rds ? 1 : 0
} 


module "s3_cdn" {
  source      = "../../modules/s3_cdn"
  name_prefix = var.name_prefix
  env         = var.env
  tags        = {
    Name        = "${var.name_prefix}-${var.env}-cdn"
    Environment = var.env
      } 
      count = var.create_s3_cdn ? 1 : 0
}

