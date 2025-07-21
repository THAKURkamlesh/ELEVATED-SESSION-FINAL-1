resource "aws_s3_bucket" "cdn_bucket" {
  bucket = "${var.name_prefix}-${var.env}-cdn"

  force_destroy = false

  tags = var.tags

  # Enable Object Lock at bucket creation time
  object_lock_enabled = true
}

resource "aws_s3_bucket_object_lock_configuration" "cdn_object_lock" {
  bucket = aws_s3_bucket.cdn_bucket.id

  rule {
    default_retention {
      mode = "GOVERNANCE"   # or "COMPLIANCE"
      days = 30
    }
  }
}


resource "aws_s3_bucket_versioning" "cdn_bucket_versioning" {
  bucket = aws_s3_bucket.cdn_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "cdn_block" {
  bucket = aws_s3_bucket.cdn_bucket.id

  block_public_acls       = false
  block_public_policy     = false 
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "cdn_bucket_policy" {
  bucket = aws_s3_bucket.cdn_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontOACOnly",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.cdn_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.cdn_distribution.arn
          }
        }
      }
    ]
  })
}


resource "aws_cloudfront_origin_access_control" "cdn_oac" {
  name                              = "${var.name_prefix}-${var.env}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
  description                       = "OAC for ${var.name_prefix}-${var.env}-cdn"
}

resource "aws_cloudfront_distribution" "cdn_distribution" {
  enabled             = true
  comment             = "CDN for ${var.name_prefix}-${var.env}"
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.cdn_bucket.bucket_regional_domain_name
    origin_id   = "s3-${aws_s3_bucket.cdn_bucket.id}"

    origin_access_control_id = aws_cloudfront_origin_access_control.cdn_oac.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-${aws_s3_bucket.cdn_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.tags
}
