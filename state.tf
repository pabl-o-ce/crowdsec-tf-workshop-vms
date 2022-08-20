terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.21.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.20.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.22.1"
    }
    # linode = {
    #   source = "linode/linode"
    #   version = "1.29.1"
    # }
    transip = {
      source = "aequitas/transip"
    }
  }
}
