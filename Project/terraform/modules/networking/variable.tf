
### Variable definitions for vpc ###
variable "network_address_space" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "public_subnet_count" {
  description = "The number of subnets to create"
  type        = number
}

variable "subnet_address_space" {
  description = "The address space for the public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Map public IP on instance launch"
  type        = list(bool)
}

### Route table variable ###
variable "rt_cidr_block" {
  description = "The CIDR block for the route table"
  type        = string
  default = "0.0.0.0/0"
}

### Tags variable ###
variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = string
}

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
