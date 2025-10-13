
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
  
variable "elb_name" {
  description = "Name of the ELB Security Group"
  type        = string
}

variable "elb_description" {
  description = "Description of the ELB Security Group"
  type        = string
}

variable "elb_ingress_rules" {
  description = "List of ELB ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "elb_egress_rules" {
  description = "List of ELB egress rules"
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

variable "elb_sg_tags" {
  description = "Tags for the ELB Security Group"
  type        = string
}
