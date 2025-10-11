
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3_bucket.bucket_name
}

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "image_urls_list" {
  description = "List of image URLs"
  value       = module.s3_bucket.image_urls_list
}
