locals {
  primary_domain = var.root_domain
  all_domains    = concat([var.root_domain], var.domain_aliases)
  
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "CloudStruc"
    Original    = "caringaldevops"
  }
  
  s3_bucket_arn = "arn:aws:s3:::${var.s3_bucket_name}"
}