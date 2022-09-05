# Workshop attacker instance
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

# Workshop defender instance
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
  name                          = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
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