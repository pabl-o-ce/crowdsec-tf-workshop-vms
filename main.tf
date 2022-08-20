# AWS provider
provider "aws" {
  # Add AWS region
  region= var.aws_region
  # Add AWS keys
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}
# Digital Ocean provider
provider "digitalocean" {
  # Add Digital Ocean token
  token = var.do_token
}
# Cloudflare provider
provider "cloudflare" {
  # Add Cloudflare token
  api_token = var.cf_token
}
# Linode provider
# provider "linode" {
#   # Add Linode token
#   token = var.ln_token
# }
# TransIP provider
provider "transip" {
  # Add account
  account_name = var.tsp_account
  # Add private_key
  private_key  = file("${path.module}/transip.pem")
}