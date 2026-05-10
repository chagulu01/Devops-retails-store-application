# Resouruce Block: Random String

resource "random_string" "random" {
  length           = 6
  special          = false
  upper            = false
}


# s3 bucket resource

resource "aws_s3_bucket" "my_bucket" {
  bucket = "dev-bucket-${random_string.random.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Owner       = "Biswa-dex"
    organization = "Dexterous"
  }
}