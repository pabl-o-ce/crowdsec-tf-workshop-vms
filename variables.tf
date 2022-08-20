#####     Cloud Provider     #####

variable "mio_cloud_provider_attacker" {
        description = "Select cloud provider:  aws | do [Digital Ocean] | tsp [transip]"
        sensitive = true
        type = string
}
variable "mio_cloud_provider_defender" {
        description = "Select cloud provider:  aws | do [Digital Ocean] | tsp [transip]"
        sensitive = true
        type = string
}
variable "mio_dns_provider" {
        description = "Select cloud provider:  cf [cloudflare] | tsp [transip]"
        sensitive = true
        type = string
}
variable "mio_user_data_path" {
        description = "Select path to user-data folder"
        sensitive = true
        type = string
}
variable "mio_number_users" {
        description = "Select number of instance"
        sensitive = true
        type = string
}

#####     AWS     #####

# Access key variable definition
variable "aws_access_key" {
        description = "Access key to AWS console"
        sensitive = true
        type = string
}
# Secret key variable definition
variable "aws_secret_key" {
        description = "Secret key to AWS console"
        sensitive = true
        type = string
}
# AWS Region Key variable definition
variable "aws_region" {
        description = "The AWS region to deploy the EC2 instance in."
        sensitive = true
        type = string
}
# Number of instances variable definition
# variable "aws_number_of_instances" {
#         description = "number of instances to be created"
#         type = number
#         sensitive = true
# }
# AWS Instance type variable definition
variable "aws_instance_type" {
        description = "AWS Instance type for EC2"
        sensitive = true
        type = string
}
# AMI ID variable attacker definition
variable "aws_image_attacker" {
        description = "The AMI to use for Attack"
        sensitive = true
        type = string
}
# AMI ID variable defense definition
variable "aws_image_defender" {
        description = "The AMI to use for Defense"
        sensitive = true
        type = string
}
# Name variable definition
variable "aws_key_name" {
        description = "Key name to use for AWS instances"
        sensitive = true
        type = string
}
# Security-group-ids variable definition
variable "aws_security_group_ids" {
        description = "The VPC subnet the instance(s) will be created in"
        sensitive = true
        type = string
}

#####     Cloudflare     #####

# Cloudflare token zone id
variable "cf_token" {
        description = "Cloudflare token for dns domain"
        type = string
        sensitive = true
}
# Cloudflare zone ID domain
variable "cf_zone_id" {
        description = "Cloudflare cf_zone_id for dns records"
        type = string
        sensitive = true
}

#####     TransIP     #####

# TransIP account
variable "tsp_account" {
        description = "TransIP auth account"
        type = string
        sensitive = true
}
# TransIP availability zone / region
variable "tsp_region" {
        description = "TransIP availability zone"
        type = string
        sensitive = true
}
# TransIP number of instances
# variable "tsp_number_of_instances" {
#         description = "number of instances to be created"
#         type = number
#         sensitive = true
# }
# TransIP type of vm instances
variable "tsp_instance_type" {
        description = "TransIP type of vm instance"
        type = string
        sensitive = true
}
# TransIP attacker OS
variable "tsp_image_attacker" {
        description = "The AMI to use for attacker"
        type = string
        sensitive = true
}
# TransIP defender OS
variable "tsp_image_defender" {
        description = "The AMI to use for defender"
        type = string
        sensitive = true
}
# TransIP defender OS
variable "tsp_domain" {
        description = "Transip Domain"
        type = string
        sensitive = true
}

#####     Digital Ocean     #####

# Digital Ocean token
variable "do_token" {
        description = "Digital Ocean token auth"
        type = string
        sensitive = true
}
# Digital Ocean region
variable "do_region" {
        description = "Digital Ocean region"
        type = string
        sensitive = true
}
# Digital Ocean number of instances
# variable "do_number_of_instances" {
#         description = "number of instances to be created"
#         type = number
#         sensitive = true
# }
# Digital Ocean instance type
variable "do_instance_type" {
        description = "Digital Ocean instance type"
        type = string
        sensitive = true
}
# Digital Ocean attacker image
variable "do_image_attacker" {
        description = "Digital Ocean attacker image"
        type = string
        sensitive = true
}
# Digital Ocean defender image
variable "do_image_defender" {
        description = "Digital Ocean defender image"
        type = string
        sensitive = true
}