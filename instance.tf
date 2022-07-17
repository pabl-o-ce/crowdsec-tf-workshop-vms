resource "aws_instance" "crowdsec_instance" {
    ami = var.ami_id
    count = var.number_of_instances
    subnet_id = var.subnet_id
    instance_type = var.instance_type
    key_name = "${var.instance_name}"
    vpc_security_group_ids = var.security-group-ids
    associate_public_ip_address = true
    tags = {
        Name = var.instance_name
    }
}