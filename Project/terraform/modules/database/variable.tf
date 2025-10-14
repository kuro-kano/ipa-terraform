
# Database Subnet Group
variable "private_subnet_id" {
  description = "List of private subnet ID for the RDS instance"
  type        = list(string)
}

variable "availability_zone" {
  description = "The availability zone for the RDS instance"
  type        = string
  default     = "us-east-1c"
}

# Database Variables
variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default = 10
}

variable "db_name" {
  description = "The name of the database"
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
  description = "The instance class to use"
  type        = string
}

variable "username" {
  description = "The master username for the database"
  type        = string
}

variable "password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "identifier" {
  description = "The identifier for the database instance"
  type        = string
}

variable "group_name" {
  description = "The name of the database group"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}
