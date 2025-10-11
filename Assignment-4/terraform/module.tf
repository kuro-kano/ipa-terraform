
module "s3_bucket" {
  source = "./modules/s3-bucket"

  # variable
  bucket_name = local.bucket_name
  region      = var.region

  # image files variable
  image_path  = "../picture"
  image_count = 2

  # tags
  tags = {
    Name = "${local.name_prefix}_bucket"
  }
}
