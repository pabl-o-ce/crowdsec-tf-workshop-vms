# Workshop attacker instance
resource "transip_vps" "crowdsec_instance_attacker" {
  # Add number of instances
  count                         = (var.mio_cloud_provider == "tsp") ? var.tsp_number_of_instances : 0
  # Availability zone
  availability_zone             = var.tsp_azone
  # Add instances type
  product_name                  = var.tsp_type
  # Add image type
  operating_system              = var.tsp_image_attacker
  # Add cloud-init on user-data folder
  install_text                  = file("${var.mio_user_data_path}/workshop-attack.yml")
  # Add description name
  description                   = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
  # Add tags [not working]
  # tags = {
  #     Environment             = "CrowdSec workshop"
  #     OS                      = "debian-11"
  # }
}
# Workshop defender instance
resource "transip_vps" "crowdsec_instance_defender" {
  # Add number of instances
  count                         = (var.mio_cloud_provider == "tsp") ? var.tsp_number_of_instances : 0
  # Availability zone
  availability_zone             = var.tsp_azone
  # Add instances type
  product_name                  = var.tsp_type
  # Add image type
  operating_system              = var.tsp_image_defender
  # Add cloud-init on user-data folder
  install_text                  = file("${var.mio_user_data_path}/workshop-blank.yml")
  # Add description name
  description                   = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
  # Add tags [not working]
  # tags = {
  #     Environment             = "CrowdSec workshop"
  #     OS                      = "ubuntu-22.04"
  # }
}
# Firewall attacker
resource "transip_vps_firewall" "crowdsec_firewall_attacker" {
  for_each                      = zipmap( transip_vps.crowdsec_instance_attacker[*].description, transip_vps.crowdsec_instance_attacker[*].name )
  vps_name                      = each.value
  is_enabled                    = true
  inbound_rule {
    description           = "SSH"
    port                  = "22"
    protocol              = "tcp"
  }
}
# Firewall defender
resource "transip_vps_firewall" "crowdsec_firewall_defender" {
  for_each                      = zipmap( transip_vps.crowdsec_instance_defender[*].description, transip_vps.crowdsec_instance_defender[*].name )
  vps_name                      = each.value
  is_enabled                    = true
  inbound_rule {
    description           = "HTTP"
    port                  = "80"
    protocol              = "tcp"
  }
  inbound_rule {
    description           = "HTTPS"
    port                  = "443"
    protocol              = "tcp"
  }
  inbound_rule {
    description           = "HTTP#1"
    port                  = "3000"
    protocol              = "tcp"
  }
  inbound_rule {
    description           = "HTTP#2"
    port                  = "4000"
    protocol              = "tcp"
  }
  inbound_rule {
    description           = "SSH"
    port                  = "22"
    protocol              = "tcp"
  }
}
# Domain as data resource instead
data "transip_domain" "crowdsec_domain" {
  name                          = var.tsp_domain
}
# DNS attacker records
resource "transip_dns_record" "crowdsec_records_attacker" {
  for_each                      = (var.mio_cloud_provider == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_attacker[*].description, transip_vps.crowdsec_instance_attacker[*].ip_address ) : (var.mio_cloud_provider == "aws" && var.mio_dns_provider == "tsp") ? zipmap( aws_instance.crowdsec_instance_attacker[*].tags.Name, aws_instance.crowdsec_instance_attacker[*].public_ip ) : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}
# DNS defender records
resource "transip_dns_record" "crowdsec_records_defender" {
  for_each                      = (var.mio_cloud_provider == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_defender[*].description, transip_vps.crowdsec_instance_defender[*].ip_address ) : (var.mio_cloud_provider == "aws" && var.mio_dns_provider == "tsp") ?  zipmap( aws_instance.crowdsec_instance_defender[*].tags.Name, aws_instance.crowdsec_instance_defender[*].public_ip ) : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}