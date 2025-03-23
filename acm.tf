# SSL/TLS certificate for HTTPS
# Covers both root domain and subdomain www.artisantiling.co.nz
resource "aws_acm_certificate" "cert" {
  provider                  = aws.certificate_region
  domain_name               = var.root_domain
  subject_alternative_names = var.domain_aliases
  validation_method         = "DNS"
  
  tags = local.common_tags
}

# Certificate validation
resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.certificate_region
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# DNS CNAME records for certificate validation:
# Creates temporary records required by AWS Certificate Manager to validate domain ownership
# These records have names and values provided by ACM
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}