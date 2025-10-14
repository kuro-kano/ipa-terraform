
### Module Variables ###
variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

### Security Group Variables ###
variable "instance_sg_name" {
  description = "Name of the Instance Security Group"
  type        = string
}

variable "instance_sg_description" {
  description = "Description of the Instance Security Group"
  type        = string
}

variable "instance_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "instance_egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
  
variable "lb_name" {
  description = "Name of the LB Security Group"
  type        = string
}

variable "lb_description" {
  description = "Description of the LB Security Group"
  type        = string
}

variable "lb_ingress_rules" {
  description = "List of LB ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "lb_egress_rules" {
  description = "List of LB egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

### Tags Variables ###
variable "instance_sg_tags" {
  description = "Tags for the Instance Security Group"
  type        = string
}

variable "lb_sg_tags" {
  description = "Tags for the LB Security Group"
  type        = string
}
