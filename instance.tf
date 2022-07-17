# Workshop Attacks Instance
resource "aws_instance" "crowdsec_instance_attack" {
    ami                         = var.ami_id
    # Number of instances
    count                       = var.number_of_instances
    subnet_id                   = var.subnet_id
    # Definition of instances type
    instance_type               = var.instance_type
    # Definition of instances names
    key_name                    = "${var.instance_name}${count.index}"
    vpc_security_group_ids      = var.security-group-ids
    associate_public_ip_address = true
    # Add the config you want to set based on cloud-init on user-data folder
    user_data                   = file("${path.module}/user-data/workshop-attack.yml")
    tags = {
        Name                    = "${var.instance_name}-${count.index}"
        Environment             = "CrowdSec Workshop"
        OS                      = var.ami_id
    }
}

# Workshop Blank Instance
resource "aws_instance" "crowdsec_instance_blank" {
    ami                         = var.ami_id
    # Number of instances
    count                       = var.number_of_instances
    subnet_id                   = var.subnet_id
    # Definition of instance type
    instance_type               = var.instance_type
    # Definition of instance names
    key_name                    = "${var.instance_name}${count.index}"
    vpc_security_group_ids      = var.security-group-ids
    associate_public_ip_address = true
    # Add the config you want to set based on cloud-init on user-data folder
    user_data                   = file("${path.module}/user-data/workshop-blank.yml")
    tags = {
        Name                    = "${var.instance_name}-${count.index}"
        Environment             = "CrowdSec Workshop"
        OS                      = var.ami_id
    }
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
#     vpc_security_group_ids      = var.security-group-ids
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
#     vpc_security_group_ids      = var.security-group-ids
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
#     vpc_security_group_ids      = var.security-group-ids
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
#     vpc_security_group_ids      = var.security-group-ids
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
#     vpc_security_group_ids      = var.security-group-ids
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
#     vpc_security_group_ids      = var.security-group-ids
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
#     vpc_security_group_ids      = var.security-group-ids
#     associate_public_ip_address = true
#     # Add the config you want to set based on cloud-init on user-data folder
#     user_data                   = file("${path.module}/user-data/npm-vps.yml")
#     tags = {
#         Name                    = var.instance_name
#     }
# }