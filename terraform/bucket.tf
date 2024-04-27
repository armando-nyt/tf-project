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

# resource "aws_s3_bucket_acl" "balde_acl" {
#   bucket = aws_s3_bucket.balde.id
#   acl    = "private"
# }

resource "aws_s3_object" "balde_site" {
  bucket       = aws_s3_bucket.balde.bucket
  key          = "balde-site"
  source       = "../assets/tf-project.html"
  content_type = "text/html"
}

data "aws_iam_policy_document" "allow_access_to_static_site" {
  statement {
    sid = "SidAllowAccessToStaticSite"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.balde_access_identity.iam_arn]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.balde.arn}/${aws_s3_object.balde_site.key}",
    ]
  }
}

resource "aws_s3_bucket_policy" "balde_policy" {
  bucket = aws_s3_bucket.balde.id
  policy = data.aws_iam_policy_document.allow_access_to_static_site.json

}
