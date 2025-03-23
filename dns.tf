data "aws_route53_zone" "main" {
  name = var.root_domain
}

# A records for both root and subdomain www pointing to CloudFront distribution:
resource "aws_route53_record" "cloudfront" {
  for_each = toset(local.all_domains)
  
  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}