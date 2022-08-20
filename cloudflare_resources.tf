# Cloudflare records for attackers vms IPv4
resource "cloudflare_record" "attacker_records" {
  # AWS or TransIP output attacker vms variable
  for_each = (var.mio_cloud_provider == "aws" && var.mio_dns_provider == "cf") ? zipmap( aws_instance.crowdsec_instance_attacker[*].tags.Name, aws_instance.crowdsec_instance_attacker[*].public_ip ) : (var.mio_cloud_provider == "tsp" && var.mio_dns_provider == "cf") ? zipmap( transip_vps.crowdsec_instance_attacker[*].description, transip_vps.crowdsec_instance_attacker[*].ip_address ) : (var.mio_cloud_provider == "do" && var.mio_dns_provider == "cf") ? zipmap( digitalocean_droplet.crowdsec_instance_attacker[*].name, digitalocean_droplet.crowdsec_instance_attacker[*].ipv4_address ) : {}
  # Add zone id
  zone_id  = "${var.cf_zone_id}"
  # Add name of subdomain record
  name    = each.key
  # Add public ip
  value   = each.value
  # Add type
  type    = "A"
  # Add proxy setup
  proxied = false
  # Add ttl
  ttl     = 1
}
# Cloudflare records for defenders vms IPv4
resource "cloudflare_record" "defender_records" {
  # AWS output defender vms variable
  for_each = (var.mio_cloud_provider == "aws" && var.mio_dns_provider == "cf") ?  zipmap( aws_instance.crowdsec_instance_defender[*].tags.Name, aws_instance.crowdsec_instance_defender[*].public_ip ) : (var.mio_cloud_provider == "tsp" && var.mio_dns_provider == "cf") ? zipmap( transip_vps.crowdsec_instance_defender[*].description, transip_vps.crowdsec_instance_defender[*].ip_address ) : (var.mio_cloud_provider == "do" && var.mio_dns_provider == "cf") ? zipmap( digitalocean_droplet.crowdsec_instance_defender[*].name, digitalocean_droplet.crowdsec_instance_defender[*].ipv4_address ) : {}
  # Add zone id
  zone_id  = "${var.cf_zone_id}"
  # Add name of subdomain record
  name    = each.key
  # Add public ip
  value   = each.value
  # Add type
  type    = "A"
  # Add proxy setup
  proxied = false
  # Add ttl
  ttl     = 1
}