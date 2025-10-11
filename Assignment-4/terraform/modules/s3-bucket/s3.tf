resource "aws_s3_bucket" "content" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "content" {
  bucket = aws_s3_bucket.content.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "content" {
  bucket = aws_s3_bucket.content.id
  policy = data.aws_iam_policy_document.content.json
}

resource "aws_s3_object" "images" {
  count = var.image_count

  bucket       = aws_s3_bucket.content.id
  key          = "images/image-${count.index + 1}"
  source       = "${path.root}/${var.image_path}/image-${count.index + 1}.png"  # ← ใช้ path.root
  content_type = "image/png"
  etag         = filemd5("${path.root}/${var.image_path}/image-${count.index + 1}.png")

  tags = merge(var.tags, {
    Name = "image-${count.index + 1}"
  })
}

