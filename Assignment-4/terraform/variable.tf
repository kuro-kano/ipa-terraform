### Sensitive Variables ###

variable "access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "token" {
  type        = string
  description = "AWS Session Token"
  sensitive   = true
}

### Non-Sensitive Variables ###

variable "ami" {
  type        = string
  description = "AMI ID"
  default     = "ami-052064a798f08f0d3"
  sensitive   = false
}

variable "key_name" {
  type        = string
  description = "Key pair name"
  default     = "vockey"
  sensitive   = false
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
  sensitive   = false
}
