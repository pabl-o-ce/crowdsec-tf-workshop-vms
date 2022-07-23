####------ AWS variables
# Access key variable definition
variable "access_key" {
        description = "Access key to AWS console"
        sensitive = true
        type = string
}
# Secret key variable definition
variable "secret_key" {
        description = "Secret key to AWS console"
        sensitive = true
        type = string
}
# Name variable definition
variable "key_name" {
        description = "Key name to AWS console"
        sensitive = true
        type = string
}
# AMI ID variable attacker definition
variable "ami_attack" {
        description = "The AMI to use for Attack"
        sensitive = true
        type = string
}
# AMI ID variable defense definition
variable "ami_defense" {
        description = "The AMI to use for Defense"
        sensitive = true
        type = string
}
# AWS Region Key variable definition
variable "aws_region" {
        description = "The AWS region to deploy the EC2 instance in."
        sensitive = true
        type = string
}
# AWS Instance type variable definition
variable "instance_type" {
        description = "AWS Instance type for EC2"
        sensitive = true
        type = string
}
# Security-group-ids variable definition
variable "security_group_ids" {
        description = "The VPC subnet the instance(s) will be created in"
        sensitive = true
        type = string
}
# Number of instances variable definition
variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
        type = number
}
####------ Digital Ocean variables
variable "do_token" {
        description = "Digital Ocean token"
        sensitive = true
        type = string
}