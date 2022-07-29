# Workshop attacker instance
resource "aws_instance" "crowdsec_instance_attack" {
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
# Security group already defined for AWS attack instances
resource "aws_network_interface_sg_attachment" "sg_attachment_attack" {
  # Add number of instances
  count                       = var.number_of_instances
  # Add security group id
  security_group_id           = var.security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_attack[count.index].primary_network_interface_id
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
output "crowdsec_workshop_info" {
  description                 = "CrowdSec workshop info"
  value                       = [aws_instance.crowdsec_instance_attack.*.public_ip,
                                aws_instance.crowdsec_instance_attack.*.public_dns,
                                aws_instance.crowdsec_instance_defender.*.public_ip,
                                aws_instance.crowdsec_instance_defender.*.public_dns]
}
# Get attacker information output
output "crowdsec_workshop_attacker" {
  description                 = "CrowdSec workshop attacker"
  value                       = aws_instance.crowdsec_instance_attack.*
  sensitive                   = true
}
# Get defender information output
output "crowdsec_workshop_defender" {
  description                 = "CrowdSec workshop defender"
  value                       = aws_instance.crowdsec_instance_defender.*
  sensitive                   = true
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
