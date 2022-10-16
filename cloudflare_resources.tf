# ------------------------- #
# Workshop Attack-Defense
# ------------------------- #
# Cloudflare records for attackers vms IPv4
resource "cloudflare_record" "attacker_records" {
  # AWS or TransIP output attacker vms variable
  for_each = (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_attacker == "aws" && var.mio_dns_provider == "cf") ? zipmap( aws_instance.crowdsec_instance_attacker[*].tags.Name, aws_instance.crowdsec_instance_attacker[*].public_ip ) : (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_attacker == "tsp" && var.mio_dns_provider == "cf") ? zipmap( transip_vps.crowdsec_instance_attacker[*].description, transip_vps.crowdsec_instance_attacker[*].ip_address ) : (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_attacker == "do" && var.mio_dns_provider == "cf") ? zipmap( digitalocean_droplet.crowdsec_instance_attacker[*].name, digitalocean_droplet.crowdsec_instance_attacker[*].ipv4_address ) : {}
  # Add zone id
  zone_id  = "${var.cf_zone_id}"
  # Add name of subdomain record
  name     = each.key
  # Add public ip
  value    = each.value
  # Add type
  type     = "A"
  # Add proxy setup
  proxied  = false
  # Add ttl
  ttl      = 1
}
# Cloudflare records for defenders vms IPv4
resource "cloudflare_record" "defender_records" {
  # AWS output defender vms variable
  for_each = (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_defender == "aws" && var.mio_dns_provider == "cf") ?  zipmap( aws_instance.crowdsec_instance_defender[*].tags.Name, aws_instance.crowdsec_instance_defender[*].public_ip ) : (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_defender == "tsp" && var.mio_dns_provider == "cf") ? zipmap( transip_vps.crowdsec_instance_defender[*].description, transip_vps.crowdsec_instance_defender[*].ip_address ) : (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_defender == "do" && var.mio_dns_provider == "cf") ? zipmap( digitalocean_droplet.crowdsec_instance_defender[*].name, digitalocean_droplet.crowdsec_instance_defender[*].ipv4_address ) : {}
  # Add zone id
  zone_id  = "${var.cf_zone_id}"
  # Add name of subdomain record
  name     = each.key
  # Add public ip
  value    = each.value
  # Add type
  type     = "A"
  # Add proxy setup
  proxied  = false
  # Add ttl
  ttl      = 1
}
# ------------------------- #
# Workshop Scenarios Parsers
# ------------------------- #
# Cloudflare records for scenarios_parsers vms IPv4
resource "cloudflare_record" "scenarios_parsers_records" {
  # AWS output defender vms variable
  for_each = (var.mio_workshop == "scenarios_parsers" && var.mio_cloud_provider_scenarios_parsers == "aws" && var.mio_dns_provider == "cf") ? zipmap( aws_instance.crowdsec_instance_scenarios_parsers[*].tags.Name, aws_instance.crowdsec_instance_scenarios_parsers[*].public_ip ) : (var.mio_workshop == "scenarios_parsers" && var.mio_cloud_provider_scenarios_parsers == "tsp" && var.mio_dns_provider == "cf") ? zipmap( transip_vps.crowdsec_instance_scenarios_parsers[*].description, transip_vps.crowdsec_instance_scenarios_parsers[*].ip_address ) : (var.mio_workshop == "scenarios_parsers" && var.mio_cloud_provider_scenarios_parsers == "do" && var.mio_dns_provider == "cf") ? zipmap( digitalocean_droplet.crowdsec_instance_scenarios_parsers[*].name, digitalocean_droplet.crowdsec_instance_scenarios_parsers[*].ipv4_address ) : {}
  # Add zone id
  zone_id  = "${var.cf_zone_id}"
  # Add name of subdomain record
  name     = each.key
  # Add public ip
  value    = each.value
  # Add type
  type     = "A"
  # Add proxy setup
  proxied  = false
  # Add ttl
  ttl      = 1
}