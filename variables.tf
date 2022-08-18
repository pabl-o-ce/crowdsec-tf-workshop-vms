#####     Cloud Provider     #####

variable "cloud_provider" {
        description = "Select cloud provider:  aws | tsp [transip]"
        sensitive = true
        type = string
}
variable "dns_provider" {
        description = "Select cloud provider:  cf [cloudflare] | tsp [transip]"
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
# Name variable definition
variable "aws_key_name" {
        description = "Key name to use for AWS instances"
        sensitive = true
        type = string
}
# AMI ID variable attacker definition
variable "aws_ami_attack" {
        description = "The AMI to use for Attack"
        sensitive = true
        type = string
}
# AMI ID variable defense definition
variable "aws_ami_defense" {
        description = "The AMI to use for Defense"
        sensitive = true
        type = string
}
# AWS Instance type variable definition
variable "aws_instance_type" {
        description = "AWS Instance type for EC2"
        sensitive = true
        type = string
}
# Security-group-ids variable definition
variable "aws_security_group_ids" {
        description = "The VPC subnet the instance(s) will be created in"
        sensitive = true
        type = string
}
# Number of instances variable definition
variable "aws_number_of_instances" {
        description = "number of instances to be created"
        type = number
        sensitive = true
}

#####     Cloudflare     #####

# Cloudflare zone ID domain
variable "cf_zone_id" {
        description = "Cloudflare cf_zone_id for dns records"
        type = string
        sensitive = true
}
# Cloudflare token zone id
variable "cf_token" {
        description = "Cloudflare token for dns domain"
        type = string
        sensitive = true
}

#####     TransIP     #####

# TransIP number of instances
variable "tsp_number_of_instances" {
        description = "number of instances to be created"
        type = number
        sensitive = true
}
# TransIP account
variable "tsp_account" {
        description = "TransIP auth account"
        type = string
        sensitive = true
}
# TransIP availability zone
variable "tsp_azone" {
        description = "TransIP availability zone"
        type = string
        sensitive = true
}
# TransIP type of vm instances
variable "tsp_type" {
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