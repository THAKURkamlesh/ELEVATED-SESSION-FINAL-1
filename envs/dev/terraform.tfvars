region           = "us-east-1"
profile          = "user1"
key_name         = "xyz-key"
public_key_path  = "~/.ssh/xyz.pub"
ami_id           = "ami-084568db4383264d4"
instance_type    = "t2.micro"
subnet_id        = "subnet-0d2bf1990f9ae3d23"  # Choose one default subnet
vpc_id           = "vpc-0f66dfa3453b3944f"
name_prefix      = "harderr"
#RDS config
db_engine              = "mysql"
db_engine_version      = "8.0"
db_instance_class      = "db.t3.micro"
db_allocated_storage   = 20
db_name                = "devdb"
db_username            = "admin"
  db_password = ""
db_subnet_ids          = ["subnet-0d2bf1990f9ae3d23", "subnet-02c585ba1ef040973"]  # Two default subnets
db_publicly_accessible = true

env = "dev"
#create_rds       = false
  create_s3_cdn = false
  