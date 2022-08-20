# Cloudflare/TransIP output data
output "crowdsec_workshop" {
  description                 = "CrowdSec workshop - Cloudflare/TransIP"
  value                       = (var.mio_dns_provider == "cf") ? flatten([
                                  [
                                    for dkey, dvalue in cloudflare_record.defender_records : [
                                      for key, value in cloudflare_record.attacker_records : { adefender_public_ip: dvalue.value, attacker_dns: value.hostname, attacker_public_ip: value.value } 
                                    ]
                                  ],
                                ]) : (var.mio_dns_provider == "tsp") ? flatten([
                                  [
                                    for dkey, dvalue in transip_vps.crowdsec_instance_defender : [
                                      for key, value in transip_vps.crowdsec_instance_attacker : { adefender_public_ip: dvalue.ip_address, attacker_dns: "${value.description}.${data.transip_domain.crowdsec_domain.id}", attacker_public_ip: value.ip_address } 
                                    ]
                                  ],
                                ]) : []
}
// defender_dns: dvalue.hostname
// defender_dns: "${dvalue.description}.${data.transip_domain.crowdsec_domain.id}"