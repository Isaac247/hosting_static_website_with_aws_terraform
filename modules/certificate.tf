
provider "aws" {
  region  = "us-east-1"
  alias   = "us-east-1"
}
resource "aws_acm_certificate" "domain_cert" {
    domain_name = var.domain
    validation_method = "DNS"
    provider = aws.us-east-1


    lifecycle {
      create_before_destroy = true
    }
  
}
# resource "aws_acm_certificate_validation" "domain_cert" {
#   provider                = aws.us-east-1
#   certificate_arn         = aws_acm_certificate.domain_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
# }