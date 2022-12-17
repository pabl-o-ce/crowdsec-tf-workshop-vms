# ------------------------- #
# Workshop Attack-Defense
# ------------------------- #
# Attacker instance
resource "aws_instance" "crowdsec_instance_attacker" {
  # Add number of instances
  count                       = (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_attacker == "aws") ? var.mio_number_users : 0
  # Add image type
  ami                         = var.aws_image_attacker
  # Add instances type
  instance_type               = var.aws_instance_type
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init
  user_data                   = file("${var.mio_user_data_path}/workshop-attack.yml")
  # EBS Volume
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 32
  }
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
      Environment             = "CrowdSec workshop: attack-defense"
      OS                      = var.aws_image_attacker
  }
}
# Defender instance
resource "aws_instance" "crowdsec_instance_defender" {
  # Add number of instances
  count                       = (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_defender == "aws") ? var.mio_number_users : 0
  # Add image type
  ami                         = var.aws_image_defender
  # Add instance type
  instance_type               = var.aws_instance_type_defense
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init
  user_data                   = file("${var.mio_user_data_path}/workshop-blank.yml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "demo0${(count.index+1)}" : "demo${(count.index+1)}"
      Environment             = "CrowdSec workshop: attack-defense"
      OS                      = var.aws_image_defender
  }
}
# Security group already defined for AWS attacker instances
resource "aws_network_interface_sg_attachment" "sg_attachment_attacker" {
  # Add number of instances
  count                       = (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_attacker == "aws") ? var.mio_number_users : 0
  # Add security group id
  security_group_id           = var.aws_security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_attacker[count.index].primary_network_interface_id
}
# Security group already defined for AWS defender instances
resource "aws_network_interface_sg_attachment" "sg_attachment_defender" {
  # Add number of instances
  count                       = (var.mio_workshop == "attack-defense" && var.mio_cloud_provider_defender == "aws") ? var.mio_number_users : 0
  # Add security group id
  security_group_id           = var.aws_security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_defender[count.index].primary_network_interface_id
}
# ------------------------- #
# Workshop Scenarios Parsers
# ------------------------- #
# Scenarios/Parsers instance
resource "aws_instance" "crowdsec_instance_scenarios_parsers" {
  # Add number of instances
  count                       = (var.mio_workshop == "scenarios-parsers" && var.mio_cloud_provider_scenarios_parsers == "aws") ? var.mio_number_users : 0
  # Add image type
  ami                         = var.aws_image_scenarios_parsers
  # Add instance type
  instance_type               = var.aws_instance_type
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init
  user_data                   = file("${var.mio_user_data_path}/vps-crowdsec.yml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "scenarios-parsers0${(count.index+1)}" : "scenarios-parsers${(count.index+1)}"
      Environment             = "CrowdSec workshop: scenarios-parsers"
      OS                      = var.aws_image_scenarios_parsers
  }
}
# ------------------------- #
# Workshop Demo
# ------------------------- #
# Attacker instance
resource "aws_instance" "crowdsec_instance_demo_attacker" {
  # Add number of instances
  count                       = (var.mio_workshop == "demo" && var.mio_cloud_provider_attacker == "aws") ? var.mio_number_users : 0
  # Add image type
  ami                         = var.aws_image_demo_attacker
  # Add instances type
  instance_type               = var.aws_instance_type
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init
  user_data                   = file("${var.mio_user_data_path}/workshop-attack.yml")
  # EBS Volume
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 32
  }
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
      Environment             = "CrowdSec workshop: demo"
      OS                      = var.aws_image_demo_attacker
  }
}
# Defender instance
resource "aws_instance" "crowdsec_instance_demo_defender" {
  # Add number of instances
  count                       = (var.mio_workshop == "demo" && var.mio_cloud_provider_defender == "aws") ? var.mio_number_users : 0
  # Add image type
  ami                         = var.aws_image_demo_defender
  # Add instance type
  instance_type               = var.aws_instance_type
  # Add key name
  key_name                    = "${var.aws_key_name}"
  # Add public ip
  associate_public_ip_address = true
  # Add cloud-init
  user_data                   = file("${var.mio_user_data_path}/blank-for-crowdsec-demo.yaml")
  # Add tags
  tags = {
      Name                    = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
      Environment             = "CrowdSec workshop: demo"
      OS                      = var.aws_image_demo_defender
  }
}  
# Security group already defined for AWS attacker instances
resource "aws_network_interface_sg_attachment" "sg_attachment_demo_attacker" {
  # Add number of instances
  count                       = (var.mio_workshop == "demo" && var.mio_cloud_provider_demo_attacker == "aws") ? var.mio_number_users : 0
  # Add security group id
  security_group_id           = var.aws_security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_demo_attacker[count.index].primary_network_interface_id
}
# Security group already defined for AWS defender instances
resource "aws_network_interface_sg_attachment" "sg_attachment_demo_defender" {
  # Add number of instances
  count                       = (var.mio_workshop == "demo" && var.mio_cloud_provider_demo_defender == "aws") ? var.mio_number_users : 0
  # Add security group id
  security_group_id           = var.aws_security_group_ids
  # Add network interface id attachment to instances
  network_interface_id        = aws_instance.crowdsec_instance_demo_defender[count.index].primary_network_interface_id
}