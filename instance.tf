# Workshop Attacks Instance
resource "aws_instance" "crowdsec_instance_attack" {
    # Type of OS image
    ami                         = var.ami_attack
    # Number of instances
    count                       = var.number_of_instances
    # Definition of instances type
    instance_type               = var.instance_type
    # Definition of key name
    key_name                    = "${var.key_name}"
    # Add a Public IP
    associate_public_ip_address = true
    # Add the config you want to set based on cloud-init on user-data folder
    user_data                   = file("${path.module}/user-data/workshop-attack.yml")
    # Tags :)
    tags = {
        Name                    = (count.index<9) ? "attacker0${(count.index+1)}" : "attacker${(count.index+1)}"
        Environment             = "CrowdSec Workshop [Attacker]"
        OS                      = var.ami_attack
    }
}
# Workshop Blank/Defender Instance
resource "aws_instance" "crowdsec_instance_blank" {
    # Type of OS image
    ami                         = var.ami_defense
    # Number of instances
    count                       = var.number_of_instances
    # Definition of instance type
    instance_type               = var.instance_type
    # Definition of key name
    key_name                    = "${var.key_name}"
    # Add a Public IP
    associate_public_ip_address = true
    # Add the config you want to set based on cloud-init on user-data folder
    user_data                   = file("${path.module}/user-data/workshop-blank.yml")
    # Tags :)
    tags = {
        Name                    = (count.index<9) ? "defender0${(count.index+1)}" : "defender${(count.index+1)}"
        Environment             = "CrowdSec Workshop [Blank/Defender]"
        OS                      = var.ami_defense
    }
}
# Security group already define in AWS attack instances
resource "aws_network_interface_sg_attachment" "sg_attachment_attack" {
  count                         = var.number_of_instances
  security_group_id             = var.security_group_ids
  network_interface_id          = aws_instance.crowdsec_instance_attack[count.index].primary_network_interface_id
}
# Security group already define in AWS Blank/Defender instances
resource "aws_network_interface_sg_attachment" "sg_attachment_defense" {
  count                         = var.number_of_instances
  security_group_id             = var.security_group_ids
  network_interface_id          = aws_instance.crowdsec_instance_blank[count.index].primary_network_interface_id
}
# Get information abouts instances after they created
output "crowdsec_workshop_info" {
  description = "CrowdSec Workshop info"
  value = [aws_instance.crowdsec_instance_attack.*.public_ip,
          aws_instance.crowdsec_instance_attack.*.public_dns,
          aws_instance.crowdsec_instance_blank.*.public_ip,
          aws_instance.crowdsec_instance_blank.*.public_dns]
}

# Tutorial Videos Wordpress Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/tutorialvids-wordpress.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }

# Tutorial Videos SSHBF Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/tutorialvids-sshbf.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }

# Tutorial Videos CrowdSec Latest Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/tutorialvids-crowdsec-latest.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }

# Tutorial Videos CrowdSec Blank Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/tutorialvids-crowdsec-blank.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }

# Tutorial Videos Blank Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/tutorialvids-blank.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }

# Tutorial Videos Attack Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/tutorialvids-attack.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }

# NPM VPS Instance
# resource "aws_instance" "crowdsec_instance" {
#     ami                         = var.ami_id
#     # Number of instances
#     count                       = var.number_of_instances
#     subnet_id                   = var.subnet_id
#     # Definition of instances type
#     instance_type               = var.instance_type
#     # Definition of instances names
#     key_name                    = "${var.instance_name}${count.index}"
#     vpc_security_group_ids      = var.security_group_ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/npm-vps.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }