variable "key_name" {}
variable "public_key_path" {}
variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "name_prefix" {}
variable "iam_instance_profile" {
  description = "IAM instance profile for EC2"
  type        = string
  default     = null
}



variable "env" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}
