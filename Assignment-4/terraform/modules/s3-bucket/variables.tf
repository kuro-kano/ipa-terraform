# module variable
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the S3 bucket"
}

# s3 bucket variable
variable "block_public_acls" {
  type        = bool
  description = "Block public ACLs for the S3 bucket"
  default     = false
}

variable "block_public_policy" {
  type        = bool
  description = "Block public policy for the S3 bucket"
  default     = false
}

variable "ignore_public_acls" {
  type        = bool
  description = "Ignore public ACLs for the S3 bucket"
  default     = false
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Restrict public access to the S3 bucket"
  default     = false
}

# image files variable
variable "image_path" {
  type        = string
  description = "Path prefix for images"
}

variable "image_count" {
  type        = number
  description = "Number of images to upload"
  default     = 0
}