provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "certificate_region"
  region = var.aws_certificate_region
}