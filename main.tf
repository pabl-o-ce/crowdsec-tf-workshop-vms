# AWS provider
provider "aws" {
  # Add AWS region
  region= var.aws_region
  # Add AWS keys
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
# Cloudflare provider
provider "cloudflare" {
  # Add Cloudflare token
  api_token = var.cf_token
}