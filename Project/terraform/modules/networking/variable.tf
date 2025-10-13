
variable "igw_tags" {
  description = "Tags for the Internet Gateway"
  type        = string
}

variable "public_subnet_tags" {
  description = "Tags for the public subnets"
  type        = list(string)
}

variable "private_subnet_tags" {
  description = "Tags for the private subnets"
  type        = string
}

variable "public_route_table_tags" {
  description = "Tags for the public route table"
  type        = string
}

variable "private_route_table_tags" {
  description = "Tags for the private route table"
  type        = string
}
