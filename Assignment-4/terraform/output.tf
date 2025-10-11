
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3_bucket.bucket_name # ← เปลี่ยนจาก aws_s3_bucket.content.id
}

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id # ← เปลี่ยนจาก aws_s3_bucket.content.id
}

output "image_urls_list" {
  description = "List of image URLs"
  value       = module.s3_bucket.image_urls_list # ← เปลี่ยนจาก for loop
}
