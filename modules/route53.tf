resource "aws_route53_zone" "main_hosted_zone" {
    name = var.domain
  
}

resource "aws_route53_record" "certificate_validation" {
    for_each = {
    for dvo in aws_acm_certificate.domain_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = aws_route53_zone.main_hosted_zone.zone_id
  type            = each.value.type
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
  
}
resource "aws_route53_record" "main_hosted_record" {
    name = var.domain
    zone_id = aws_route53_zone.main_hosted_zone.id 
    type = "A"

    alias {
      evaluate_target_health = false
      name = aws_cloudfront_distribution.site_distribution.domain_name
      zone_id = aws_cloudfront_distribution.site_distribution.hosted_zone_id
    }
}