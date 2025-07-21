variable "vpc_id" {
  type = string
}

variable "ec2_security_group_id" {
  type = string
  description = "The security group ID of the EC2 instance allowed to access RDS"
}


variable "name_prefix" {
  type = string
}


