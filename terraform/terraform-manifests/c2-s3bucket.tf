# Resouruce Block: Random String

resource "random_string" "random" {
  length           = 6
  special          = false
  upper            = false
}


# s3 bucket resource

resource "aws_s3_bucket" "my_bucket" {
  bucket = "dev-bucket- ${var.environment_name}-${var.aws_region}-${random_string.random.result}"

  tags = {
    Name        = "My bucket"
    Environment = var.environment_name
    Owner       = "DevOps Team"
    project     = "remote-state-management-bucket for ${var.environment_name}"
    organization = "Dexterous"
  }
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access" {
  bucket = aws_s3_bucket.my_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}