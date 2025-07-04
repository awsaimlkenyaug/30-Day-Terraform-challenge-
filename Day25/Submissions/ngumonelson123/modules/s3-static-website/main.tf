resource "aws_s3_bucket" "static_site" {
  bucket            = var.bucket_name

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.static_site.arn}/*"
    }]
  })

  depends_on = [aws_s3_bucket_public_access_block.allow_public_policy]
}

resource "aws_s3_bucket_public_access_block" "allow_public_policy" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
