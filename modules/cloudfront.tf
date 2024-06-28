resource "aws_cloudfront_distribution" "site_distribution" {
  enabled = true
  aliases = [var.domain]
  default_root_object = var.default_document
  is_ipv6_enabled = true
  wait_for_deployment = true

  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
    origin_id = aws_s3_bucket.website_bucket.bucket
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations = []
    }
    
  }
  

  default_cache_behavior {
    allowed_methods = ["GET","HEAD","OPTIONS" ]
    cached_methods = ["GET","HEAD","OPTIONS"]
    cache_policy_id = "2e54312d-136d-493c-8eb9-b001f22f67d2"
    target_origin_id = aws_s3_bucket.website_bucket.bucket
    viewer_protocol_policy = "redirect-to-https"
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.domain_cert.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
    
  }

}

resource "aws_cloudfront_origin_access_control" "main" {
    name = "s3-cloudfront-oac-test"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
  
}