# creates S3  bucket and object to host html for static site

locals {
  s3_origin_id = "baldeS3OriginId"
}

resource "aws_s3_bucket" "balde" {
  bucket = "cdn-bucket-for-static-site"

  tags = {
    Name        = "CDN Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "balde_acl" {
  bucket = aws_s3_bucket.balde.id
  acl    = "private"
}

resource "aws_s3_object" "balde_site" {
  bucket = aws_s3_bucket.balde.bucket
  key    = "balde-site"
  source = "../assets/tf-project.html"
}
