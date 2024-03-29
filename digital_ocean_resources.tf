# ------------------------- #
# Workshop Attack-Defense
# ------------------------- #
# Attacker instance
resource "digitalocean_droplet" "crowdsec_instance_attacker" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_attacker == "do") ? var.mio_number_users : 0
  # Add region
  region                        = var.do_region
  # Add image type "ubuntu-18-04-x64"
  image                         = var.do_image_attacker
  # Add instances type "s-1vcpu-1gb"
  size                          = var.do_instance_type
  # Add name
  name                          = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
  # Add cloud-init
  user_data                     = file("${var.mio_user_data_path}/workshop-attack.yml")
  # Add tags
  tags = [
      (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
  ]
}

# Defender instance
resource "digitalocean_droplet" "crowdsec_instance_defender" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_defender == "do") ? var.mio_number_users : 0
  # Add region
  region                        = var.do_region
  # Add image type "ubuntu-18-04-x64"
  image                         = var.do_image_defender
  # Add instances type "s-1vcpu-1gb"
  size                          = var.do_instance_type
  # Add name
  name                          = (count.index<9) ? "demo0${(count.index+1)}" : "demo${(count.index+1)}"
  # Add cloud-init
  user_data                     = file("${var.mio_user_data_path}/workshop-blank.yml")
  # Add tags
  tags = [
      (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
  ]
}
# Firewall attacker
resource "digitalocean_firewall" "crowdsec_firewall_attacker" {
  count                         = "${var.mio_cloud_provider_attacker == "do" ? 1 : 0}"
  name                          = "crowdsec-workshop-attacker-firewall"
  droplet_ids                   = (var.mio_cloud_provider_attacker == "do") ? concat(digitalocean_droplet.crowdsec_instance_attacker[*].id) : []
  inbound_rule {
    port_range              = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "8080"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
 }
# Firewall defender
resource "digitalocean_firewall" "crowdsec_firewall_defender" {
  count                         = "${var.mio_cloud_provider_defender == "do" ? 1 : 0}"
  name                          = "crowdsec-workshop-defender-firewall"
  droplet_ids                   = (var.mio_cloud_provider_defender == "do") ? concat(digitalocean_droplet.crowdsec_instance_defender[*].id) : []
  inbound_rule {
    port_range              = "80"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "443"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "3000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "4000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
   inbound_rule {
    port_range              = "5000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
}
# ------------------------- #
# Workshop Scenarios Parsers
# ------------------------- #
# Scenarios Parsers instance
resource "digitalocean_droplet" "crowdsec_instance_scenarios_parsers" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_scenarios_parsers == "do") ? var.mio_number_users : 0
  # Add region
  region                        = var.do_region
  # Add image type "ubuntu-18-04-x64"
  image                         = var.do_image_scenarios_parsers
  # Add instances type "s-1vcpu-1gb"
  size                          = var.do_instance_type
  # Add name
  name                          = (count.index<9) ? "scenarios-parsers0${(count.index+1)}" : "scenarios-parsers${(count.index+1)}"
  # Add cloud-init
  user_data                     = file("${var.mio_user_data_path}/vps-crowdsec.yml")
  # Add tags
  tags = [
      (count.index<9) ? "scenarios-parsers0${(count.index+1)}" : "scenarios-parsers${(count.index+1)}"
  ]
}
# Firewall Scenarios/Parsers
resource "digitalocean_firewall" "crowdsec_firewall_scenarios_parsers" {
  count                         = "${var.mio_cloud_provider_scenarios_parsers == "do" ? 1 : 0}"
  name                          = "crowdsec-workshop-scenarios-parsers-firewall"
  droplet_ids                   = (var.mio_cloud_provider_scenarios_parsers == "do") ? concat(digitalocean_droplet.crowdsec_instance_scenarios_parsers[*].id) : []
  inbound_rule {
    port_range              = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
 }
 # ------------------------- #
# Workshop Demo
# ------------------------- #
# Attacker instance
resource "digitalocean_droplet" "crowdsec_instance_demo_attacker" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_demo_attacker == "do") ? var.mio_number_users : 0
  # Add region
  region                        = var.do_region
  # Add image type "ubuntu-18-04-x64"
  image                         = var.do_image_demo_attacker
  # Add instances type "s-1vcpu-1gb"
  size                          = var.do_instance_type
  # Add name
  name                          = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
  # Add cloud-init
  user_data                     = file("${var.mio_user_data_path}/workshop-attack.yml")
  # Add tags
  tags = [
      (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
  ]
}

# Defender instance
resource "digitalocean_droplet" "crowdsec_instance_demo_defender" {
  # Add number of instances
  count                         = (var.mio_cloud_provider_demo_defender == "do") ? var.mio_number_users : 0
  # Add region
  region                        = var.do_region
  # Add image type "ubuntu-18-04-x64"
  image                         = var.do_image_demo_defender
  # Add instances type "s-1vcpu-1gb"
  size                          = var.do_instance_type
  # Add name
  name                          = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
  # Add cloud-init
  user_data                     = file("${var.mio_user_data_path}/blank-for-crowdsec-demo.yaml")
  # Add tags
  tags = [
      (count.index<9) ? "demo0${(count.index+1)}" : "demo${(count.index+1)}"
  ]
}
# Firewall attacker
resource "digitalocean_firewall" "crowdsec_firewall_demo_attacker" {
  count                         = "${var.mio_cloud_provider_demo_attacker == "do" ? 1 : 0}"
  name                          = "crowdsec-workshop-demo-attacker-firewall"
  droplet_ids                   = (var.mio_cloud_provider_demo_attacker == "do") ? concat(digitalocean_droplet.crowdsec_instance_demo_attacker[*].id) : []
  inbound_rule {
    port_range              = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "8080"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
 }
# Firewall defender
resource "digitalocean_firewall" "crowdsec_firewall_demo_defender" {
  count                         = "${var.mio_cloud_provider_demo_defender == "do" ? 1 : 0}"
  name                          = "crowdsec-workshop-demo-defender-firewall"
  droplet_ids                   = (var.mio_cloud_provider_demo_defender == "do") ? concat(digitalocean_droplet.crowdsec_instance_demo_defender[*].id) : []
  inbound_rule {
    port_range              = "80"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "443"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "3000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "4000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
   inbound_rule {
    port_range              = "5000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port_range              = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
}