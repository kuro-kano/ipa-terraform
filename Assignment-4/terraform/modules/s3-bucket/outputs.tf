
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.content.id
}

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.content.id
}

output "image_urls_list" {
  description = "List of image URLs"
  value = [
    for obj in aws_s3_object.images : "https://${aws_s3_bucket.content.bucket_domain_name}/${obj.key}"
  ]
}
