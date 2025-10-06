
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy_document" "content" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.content.arn}/*"
    ]
  }
}
