variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "Username for the database"
  type        = string
}



variable "subnet_ids" {
  description = "List of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
}
variable "password" {
  description = "RDS password"
  type        = string
}
