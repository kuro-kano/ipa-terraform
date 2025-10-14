
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region

  default_tags {
    tags = {
      "label"                = "${local.tags_prefix}-motto"
      "${local.tags_prefix}" = "${local.name_prefix}"
    }
  }
}
