
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "content" {
  bucket = "${local.name_prefix}-content-${random_string.bucket_suffix.result}"

  tags = {
    Name = "${local.name_prefix}_content_bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "content" {
  bucket = aws_s3_bucket.content.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "content" {
  bucket = aws_s3_bucket.content.id
  policy = data.aws_iam_policy_document.content.json
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.content.id
  key          = "index.html"
  source       = "../website/index.html"
  content_type = "text/html"
  etag         = filemd5("../website/index.html")

  tags = {
    Name = "${local.web}_index"
  }
}

resource "aws_s3_object" "style" {
  bucket       = aws_s3_bucket.content.id
  key          = "style.css"
  source       = "../website/style.css"
  content_type = "text/css"
  etag         = filemd5("../website/style.css")

  tags = {
    Name = "${local.web}_style"
  }
}