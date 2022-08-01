terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.20.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.21.0"
    }
  }
}
