# Workshop attacker instance
resource "aws_instance" "crowdsec_instance_attacker" {
  # Add number of instances
  count                       = (var.mio_cloud_provider == "aws") ? var.aws_number_of_instances : 0
  # Add image type
  ami                         = var.aws_ami_attack
  # Add instances type
  instance_type               = var.aws_instance_type
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init on user-data folder
  user_data                   = file("${var.mio_user_data_path}/workshop-attack.yml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
      Environment             = "CrowdSec workshop"
      OS                      = var.aws_ami_attack
  }
}
# Workshop defender instance
resource "aws_instance" "crowdsec_instance_defender" {
  # Add number of instances
  count                       = (var.mio_cloud_provider == "aws") ? var.aws_number_of_instances : 0
  # Add image type
  ami                         = var.aws_ami_defense
  # Add instance type
  instance_type               = var.aws_instance_type
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init on user-data folder
  user_data                   = file("${var.mio_user_data_path}/user-data/workshop-blank.yml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
      Environment             = "CrowdSec workshop"
      OS                      = var.aws_ami_defense
  }
}
# Security group already defined for AWS attacker instances
resource "aws_network_interface_sg_attachment" "sg_attachment_attacker" {
  # Add number of instances
  count                       = (var.mio_cloud_provider == "aws") ? var.aws_number_of_instances : 0
  # Add security group id
  security_group_id           = var.aws_security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_attacker[count.index].primary_network_interface_id
}
# Security group already defined for AWS defender instances
resource "aws_network_interface_sg_attachment" "sg_attachment_defense" {
  # Add number of instances
  count                       = (var.mio_cloud_provider == "aws") ? var.aws_number_of_instances : 0
  # Add security group id
  security_group_id           = var.aws_security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_defender[count.index].primary_network_interface_id
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
