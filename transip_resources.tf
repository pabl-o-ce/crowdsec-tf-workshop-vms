# ------------------------- #
# Workshop Attack-Defense
# ------------------------- #
# Attacker instance
resource "transip_vps" "crowdsec_instance_attacker" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_attacker == "tsp") ? var.mio_number_users : 0
  # Availability zone
  availability_zone             = var.tsp_region
  # Add instances type
  product_name                  = var.tsp_instance_type
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
# Defender instance
resource "transip_vps" "crowdsec_instance_defender" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_defender == "tsp") ? var.mio_number_users : 0
  # Availability zone
  availability_zone             = var.tsp_region
  # Add instances type
  product_name                  = var.tsp_instance_type
  # Add image type
  operating_system              = var.tsp_image_defender
  # Add cloud-init on user-data folder
  install_text                  = file("${var.mio_user_data_path}/workshop-blank.yml")
  # Add description name
  description                   = (count.index<9) ? "demo0${(count.index+1)}" : "demo${(count.index+1)}"
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
  inbound_rule {
    description           = "HTTP#1"
    port                  = "8080"
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
    description           = "HTTP#3"
    port                  = "5000"
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
  for_each                      = (var.mio_cloud_provider_attacker == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_attacker[*].description, transip_vps.crowdsec_instance_attacker[*].ip_address ) : (var.mio_cloud_provider_attacker == "aws" && var.mio_dns_provider == "tsp") ? zipmap( aws_instance.crowdsec_instance_attacker[*].tags.Name, aws_instance.crowdsec_instance_attacker[*].public_ip ) : (var.mio_cloud_provider_attacker == "do" && var.mio_dns_provider == "tsp") ? zipmap( digitalocean_droplet.crowdsec_instance_attacker[*].name, digitalocean_droplet.crowdsec_instance_attacker[*].ipv4_address ) : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}
# DNS defender records
resource "transip_dns_record" "crowdsec_records_defender" {
  for_each                      = (var.mio_cloud_provider_defender == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_defender[*].description, transip_vps.crowdsec_instance_defender[*].ip_address ) : (var.mio_cloud_provider_defender == "aws" && var.mio_dns_provider == "tsp") ?  zipmap( aws_instance.crowdsec_instance_defender[*].tags.Name, aws_instance.crowdsec_instance_defender[*].public_ip ) : (var.mio_cloud_provider_defender == "do" && var.mio_dns_provider == "tsp") ? zipmap( digitalocean_droplet.crowdsec_instance_defender[*].name, digitalocean_droplet.crowdsec_instance_defender[*].ipv4_address )  : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}
# ------------------------- #
# Workshop Scenarios Parsers
# ------------------------- #
# Scenarios Parsers instance
resource "transip_vps" "crowdsec_instance_scenarios_parsers" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_scenarios_parsers == "tsp") ? var.mio_number_users : 0
  # Availability zone
  availability_zone             = var.tsp_region
  # Add instances type
  product_name                  = var.tsp_instance_type
  # Add image type
  operating_system              = var.tsp_image_scenarios_parsers
  # Add cloud-init on user-data folder
  install_text                  = file("${var.mio_user_data_path}/vps-crowdsec.yml")
  # Add description name
  description                   = (count.index<9) ? "scenarios-parsers0${(count.index+1)}" : "scenarios-parsers${(count.index+1)}"
}
# Firewall Scenarios/Parsers
resource "transip_vps_firewall" "crowdsec_firewall_scenarios_parsers" {
  for_each                      = zipmap( transip_vps.crowdsec_instance_scenarios_parsers[*].description, transip_vps.crowdsec_instance_scenarios_parsers[*].name )
  vps_name                      = each.value
  is_enabled                    = true

  inbound_rule {
    description           = "SSH"
    port                  = "22"
    protocol              = "tcp"
  }
}
# DNS defender records
resource "transip_dns_record" "crowdsec_records_scenarios_parsers" {
  for_each                      = (var.mio_cloud_provider_scenarios_parsers == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_scenarios_parsers[*].description, transip_vps.crowdsec_instance_scenarios_parsers[*].ip_address ) : (var.mio_cloud_provider_scenarios_parsers == "aws" && var.mio_dns_provider == "tsp") ?  zipmap( aws_instance.crowdsec_instance_scenarios_parsers[*].tags.Name, aws_instance.crowdsec_instance_scenarios_parsers[*].public_ip ) : (var.mio_cloud_provider_scenarios_parsers == "do" && var.mio_dns_provider == "tsp") ? zipmap( digitalocean_droplet.crowdsec_instance_scenarios_parsers[*].name, digitalocean_droplet.crowdsec_instance_scenarios_parsers[*].ipv4_address )  : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}
# ------------------------- #
# Workshop Demo
# ------------------------- #
# Attacker instance
resource "transip_vps" "crowdsec_instance_demo_attacker" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_demo_attacker == "tsp") ? var.mio_number_users : 0
  # Availability zone
  availability_zone             = var.tsp_region
  # Add instances type
  product_name                  = var.tsp_instance_type
  # Add image type
  operating_system              = var.tsp_image_demo_attacker
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
# Defender instance
resource "transip_vps" "crowdsec_instance_demo_defender" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_demo_defender == "tsp") ? var.mio_number_users : 0
  # Availability zone
  availability_zone             = var.tsp_region
  # Add instances type
  product_name                  = var.tsp_instance_type
  # Add image type
  operating_system              = var.tsp_image_demo_defender
  # Add cloud-init on user-data folder
  install_text                  = file("${var.mio_user_data_path}/blank-for-crowdsec-demo.yaml")
  # Add description name
  description                   = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
  # Add tags [not working]
  # tags = {
  #     Environment             = "CrowdSec workshop"
  #     OS                      = "ubuntu-22.04"
  # }
}
# Firewall attacker
resource "transip_vps_firewall" "crowdsec_firewall_demo_attacker" {
  for_each                      = zipmap( transip_vps.crowdsec_instance_demo_attacker[*].description, transip_vps.crowdsec_instance_demo_attacker[*].name )
  vps_name                      = each.value
  is_enabled                    = true
  inbound_rule {
    description           = "SSH"
    port                  = "22"
    protocol              = "tcp"
  }
  inbound_rule {
    description           = "HTTP#1"
    port                  = "8080"
    protocol              = "tcp"
  }
}
# Firewall defender
resource "transip_vps_firewall" "crowdsec_firewall_demo_defender" {
  for_each                      = zipmap( transip_vps.crowdsec_instance_demo_defender[*].description, transip_vps.crowdsec_instance_demo_defender[*].name )
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
    description           = "HTTP#3"
    port                  = "5000"
    protocol              = "tcp"
  }
  inbound_rule {
    description           = "SSH"
    port                  = "22"
    protocol              = "tcp"
  }
}

# DNS attacker records
resource "transip_dns_record" "crowdsec_records_demo_attacker" {
  for_each                      = (var.mio_cloud_provider_demo_attacker == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_demo_attacker[*].description, transip_vps.crowdsec_instance_demo_attacker[*].ip_address ) : (var.mio_cloud_provider_demo_attacker == "aws" && var.mio_dns_provider == "tsp") ? zipmap( aws_instance.crowdsec_instance_demo_attacker[*].tags.Name, aws_instance.crowdsec_instance_demo_attacker[*].public_ip ) : (var.mio_cloud_provider_demo_attacker == "do" && var.mio_dns_provider == "tsp") ? zipmap( digitalocean_droplet.crowdsec_instance_demo_attacker[*].name, digitalocean_droplet.crowdsec_instance_demo_attacker[*].ipv4_address ) : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}
# DNS defender records
resource "transip_dns_record" "crowdsec_records_demo_defender" {
  for_each                      = (var.mio_cloud_provider_demo_defender == "tsp" && var.mio_dns_provider == "tsp") ? zipmap( transip_vps.crowdsec_instance_demo_defender[*].description, transip_vps.crowdsec_instance_demo_defender[*].ip_address ) : (var.mio_cloud_provider_demo_defender == "aws" && var.mio_dns_provider == "tsp") ?  zipmap( aws_instance.crowdsec_instance_demo_defender[*].tags.Name, aws_instance.crowdsec_instance_demo_defender[*].public_ip ) : (var.mio_cloud_provider_demo_defender == "do" && var.mio_dns_provider == "tsp") ? zipmap( digitalocean_droplet.crowdsec_instance_demo_defender[*].name, digitalocean_droplet.crowdsec_instance_demo_defender[*].ipv4_address )  : {}
  name                          = each.key
  content                       = ["${each.value}"]
  domain                        = data.transip_domain.crowdsec_domain.id
  type                          = "A"
}