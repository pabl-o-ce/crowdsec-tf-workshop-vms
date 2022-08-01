# Workshop attacker instance
resource "aws_instance" "crowdsec_instance_attacker" {
  # Add number of instances
  count                       = var.number_of_instances
  # Add image type
  ami                         = var.ami_attack
  # Add instances type
  instance_type               = var.instance_type
  # Add key name
  key_name                    = "${var.key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init on user-data folder
  user_data                   = file("${path.module}/user-data/workshop-attack.yml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
      Environment             = "CrowdSec workshop"
      OS                      = var.ami_attack
  }
}
# Workshop defender instance
resource "aws_instance" "crowdsec_instance_defender" {
  # Add number of instances
  count                       = var.number_of_instances
  # Add image type
  ami                         = var.ami_defense
  # Add instance type
  instance_type               = var.instance_type
  # Add key name
  key_name                    = "${var.key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init on user-data folder
  user_data                   = file("${path.module}/user-data/workshop-blank.yml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
      Environment             = "CrowdSec workshop"
      OS                      = var.ami_defense
  }
}
# Security group already defined for AWS attacker instances
resource "aws_network_interface_sg_attachment" "sg_attachment_attacker" {
  # Add number of instances
  count                       = var.number_of_instances
  # Add security group id
  security_group_id           = var.security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_attacker[count.index].primary_network_interface_id
}
# Security group already defined for AWS defender instances
resource "aws_network_interface_sg_attachment" "sg_attachment_defense" {
  # Add number of instances
  count                       = var.number_of_instances
  # Add security group id
  security_group_id           = var.security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_defender[count.index].primary_network_interface_id
}
# Get all instances output
output "crowdsec_workshop_info_a" {
  description                 = "CrowdSec workshop info"
  value                       = flatten([
                                  [
                                    for key, value in aws_instance.crowdsec_instance_attacker : { name: value.tags.Name, public_ip: value.public_ip, public_dns: value.public_dns}
                                  ],
                                  [
                                    for key, value in aws_instance.crowdsec_instance_defender : { name: value.tags.Name, public_ip: value.public_ip, public_dns: value.public_dns}
                                  ]
                                ])
}
output "crowdsec_workshop_info_aws" {
  description                 = "CrowdSec workshop info"
  value                       = {
                                  attackers: [
                                    for key, value in aws_instance.crowdsec_instance_attacker : { name: value.tags.Name, public_ip: value.public_ip, public_dns: value.public_dns}
                                  ],
                                  defenders: [
                                    for key, value in aws_instance.crowdsec_instance_defender : { name: value.tags.Name, public_ip: value.public_ip, public_dns: value.public_dns}
                                  ]
                                }
}

# Tutorial videos wordpress instance
# <Not yet defined>

# Tutorial videos SSHBF instance
# <Not yet defined>

# Tutorial videos CrowdSec latest instance
# <Not yet defined>

# Tutorial videos CrowdSec blank instance
# <Not yet defined>

# Tutorial videos blank instance
# <Not yet defined>

# Tutorial videos attack instance
# <Not yet defined>

# NPM VPS instance
# <Not yet defined>
