# Cloudflare records for attackers vms IPv4
resource "cloudflare_record" "attacker_records" {
  # AWS output attacker vms variable
  for_each = zipmap( aws_instance.crowdsec_instance_attacker[*].tags.Name, aws_instance.crowdsec_instance_attacker[*].public_ip )
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
  for_each = zipmap( aws_instance.crowdsec_instance_defender[*].tags.Name, aws_instance.crowdsec_instance_defender[*].public_ip )
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
# Cloudflare output data
output "crowdsec_workshop_info_cloudflare" {
  description                 = "CrowdSec workshop info"
  value                       = {
                                  attackers: [
                                    for key, value in cloudflare_record.attacker_records : { dns: value.hostname, public_ip: value.value}
                                  ],
                                  defenders: [
                                    for key, value in cloudflare_record.defender_records : { dns: value.hostname, public_ip: value.value}
                                  ]
                                }
}
output "crowdsec_workshop_info_cloudflare_list" {
  description                 = "CrowdSec workshop info"
  value                       = flatten([
                                  [
                                    for key, value in cloudflare_record.attacker_records : { dns: value.hostname, public_ip: value.value}
                                  ],
                                  [
                                    for key, value in cloudflare_record.defender_records : { dns: value.hostname, public_ip: value.value}
                                  ]
                                ])
}