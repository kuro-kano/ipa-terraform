
resource "random_string" "content" {
  length  = 8
  special = false
  upper   = false
}

locals {
  name_prefix = "itkmitl"
  bucket_name = "${local.name_prefix}-content-${random_string.content.result}"
}
