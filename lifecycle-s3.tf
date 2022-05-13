resource "aws_s3_bucket" "lifecycle" {
  bucket        = "${var.project_name}-lifecycle"
  force_destroy = "false"
}

resource "aws_s3_bucket_public_access_block" "lifecycle" {
  bucket = aws_s3_bucket.lifecycle.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "lifecycle_acl" {
  bucket = aws_s3_bucket.lifecycle.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_lifecycle" {
  bucket = aws_s3_bucket.lifecycle.id
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ssedc_lifecycle" {
  bucket = aws_s3_bucket.lifecycle.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "expiration_lifecycle" {
  bucket = aws_s3_bucket.lifecycle.id

  rule {
    id = "OneDayExpirationRule"
    expiration {
      days = 1
    }
    status = "Enabled"
  }
}
