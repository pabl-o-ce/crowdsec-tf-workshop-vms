# Cloudflare/TransIP output data
output "crowdsec_workshop" {
  description                 = "CrowdSec workshop - Cloudflare/TransIP"
  value                       = (var.mio_dns_provider == "cf") ? flatten([
                                  [
                                    for key, value in cloudflare_record.attacker_records : [
                                      for dkey, dvalue in cloudflare_record.defender_records : { attacker_dns: value.hostname, attacker_public_ip: value.value, defender_dns: dvalue.hostname, defender_public_ip: dvalue.value } 
                                    ]
                                  ],
                                ]) : (var.mio_dns_provider == "tsp") ? flatten([
                                  [
                                    for key, value in transip_vps.crowdsec_instance_attacker : [
                                      for dkey, dvalue in transip_vps.crowdsec_instance_defender : { attacker_dns: "${value.description}.${data.transip_domain.crowdsec_domain.id}", attacker_public_ip: value.ip_address, defender_dns: "${dvalue.description}.${data.transip_domain.crowdsec_domain.id}", defender_public_ip: dvalue.ip_address } 
                                    ]
                                  ],
                                ]) : []
}