variable "region" {}
variable "profile" {}
variable "key_name" {}
variable "public_key_path" {}
variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "vpc_id" {}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "db_engine" {}
variable "db_engine_version" {}
variable "db_instance_class" {}
variable "db_allocated_storage" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_subnet_ids" {
  type = list(string)
}
variable "db_publicly_accessible" {}

variable "env" {
  description = "Environment (e.g. dev, prod)"
  type        = string
}
variable "create_rds" {
  description = "Whether to create RDS resources"
  type        = bool
  default     = true
}
variable "create_s3_cdn" {
  type    = bool
  default = true
}
