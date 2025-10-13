
# Instance variable
variable "count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ami" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "vockey"
}

variable "vpc_security_group_ids" {
  description = "Security Groups for the EC2 instances"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Subnets for the EC2 instances"
  type        = list(string)
  
}

# Tags variables
variable "instance_tags" {
  description = "Tags for the EC2 instances"
  type        = string
}
