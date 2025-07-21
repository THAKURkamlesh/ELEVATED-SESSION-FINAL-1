output "bucket_name" {
  value = aws_s3_bucket.cdn_bucket.bucket
}

output "cdn_domain_name" {
  value = aws_cloudfront_distribution.cdn_distribution.domain_name
}
