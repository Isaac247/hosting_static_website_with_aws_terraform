resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket
}

resource "aws_s3_bucket_website_configuration" "site_bucket_config" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = var.default_document
  }
  error_document {
    key = var.error_document
  }
  
}
resource "aws_s3_object" "site" {
    for_each = fileset("invoice-creator", "**/*")
    bucket = aws_s3_bucket.website_bucket.id
    key    = "each.key"
    source = "invoice-creator/${each.key}"
    content_type = each.key    
}

data "aws_iam_policy_document" "cloudfront_policy_document"{
    statement {
      principals {
        identifiers = ["cloudfront.amazonaws.com"]
        type = "Service"
      }
      actions = ["s3:GetObject"]
      effect = "Allow"
      resources = [
        "${aws_s3_bucket.website_bucket.arn}/*"
      ]
    }
}

resource "aws_s3_bucket_policy" "site_bucket_policy" {
    bucket = aws_s3_bucket.website_bucket.id
    policy = data.aws_iam_policy_document.cloudfront_policy_document.json
  
}
