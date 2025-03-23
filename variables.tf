variable "aws_region" {
  description = "AWS region"
  default     = "ap-southeast-2"
}

variable "aws_certificate_region" {
  description = "AWS region for ACM certificate (must be us-east-1 for CloudFront)"
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  default     = "production"
}

variable "root_domain" {
  description = "Root domain for the application"
  default     = "artisantiling.co.nz"
}

variable "domain_aliases" {
  description = "Additional domain aliases for the application"
  type        = list(string)
  default     = ["www.artisantiling.co.nz"]
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default     = "caringaldevops"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  default     = "PriceClass_All"
  # Options: PriceClass_100, PriceClass_200, PriceClass_All
}

variable "s3_folders" {
  description = "List of folders to create in S3 bucket"
  type        = list(string)
  default     = ["avatar_images/", "react-build/", "student_files/"]
}

variable "intelligent_tiering_folders" {
  description = "List of folders to enable intelligent tiering"
  type        = list(string)
  default     = ["avatar_images/", "student_files/"]
}

variable "archive_access_days" {
  description = "Days before moving to archive access tier"
  default     = 90
}

variable "deep_archive_access_days" {
  description = "Days before moving to deep archive access tier"
  default     = 365
}

variable "multipart_upload_cleanup_days" {
  description = "Days after which incomplete multipart uploads are cleaned up"
  default     = 7
}

variable "tls_version" {
  description = "Minimum TLS version for CloudFront"
  default     = "TLSv1.2_2021"
}

variable "waf_rate_limit" {
  description = "Rate limit for WAF rules (requests per 5 minutes)"
  default     = 2000
}

variable "s3_cors_max_age" {
  description = "Max age in seconds for CORS"
  default     = 3000
}