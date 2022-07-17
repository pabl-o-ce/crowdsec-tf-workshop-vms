resource "aws_instance" "crowdsec_instance" {
    ami = var.ami_id
    count = var.number_of_instances
    subnet_id = var.subnet_id
    instance_type = var.instance_type
    key_name = "${var.instance_name}${index}"
    vpc_security_group_ids = var.security-group-ids
    associate_public_ip_address = true
    # Add the config you want to set based on cloud-init on user-data folder
    user_data   = file("${path.module}/user-data/cloud-init.yml")
    tags = {
        Name = var.instance_name
    }
}