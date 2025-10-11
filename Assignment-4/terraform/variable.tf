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

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
  sensitive   = false
}

### S3 Bucket Variables ###
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default     = "value"
}
