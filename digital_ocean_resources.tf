# Workshop attacker instance
resource "digitalocean_droplet" "crowdsec_instance_attacker" {
  # Add number of instances
  count                         = (var.mio_cloud_provider == "do") ? var.do_number_of_instances : 0
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
      (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}",
      "CrowdSec workshop",
      var.do_image_attacker
  ]
}

# Workshop defender instance
resource "digitalocean_droplet" "crowdsec_instance_defender" {
  # Add number of instances
  count                         = (var.mio_cloud_provider == "do") ? var.do_number_of_instances : 0
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
      (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}",
      "CrowdSec workshop",
      var.do_image_defender
  ]
}
# Firewall attacker
resource "digitalocean_firewall" "crowdsec_firewall_attacker" {
  name                          = "crowdsec-workshop-attacker-firewall"
  droplet_ids                   = concat(digitalocean_droplet.crowdsec_instance_attacker[*].id)
  inbound_rule {
    port                    = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port                    = "8080"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
 }
# Firewall defender
resource "digitalocean_firewall" "crowdsec_firewall_defender" {
  name                          = "crowdsec-workshop-defender-firewall"
  droplet_ids                   = concat(digitalocean_droplet.crowdsec_instance_defender[*].id)
  inbound_rule {
    port                    = "80"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port                    = "443"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port                    = "3000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port                    = "4000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
   inbound_rule {
    port                    = "5000"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    port                    = "22"
    protocol                = "tcp"
    source_addresses        = ["0.0.0.0/0", "::/0"]
  }
}