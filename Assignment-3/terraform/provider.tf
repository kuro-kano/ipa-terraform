
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region
}

locals {
  name_prefix = "itkmitl"
  server_name = "${local.name_prefix}-web-server"
  web         = "${local.name_prefix}_web"
}
