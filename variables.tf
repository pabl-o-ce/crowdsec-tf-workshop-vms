# AMI ID variable definition
variable "ami_id" {
        description = "The AMI to use"
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
        description = "instance type for ec2"
        sensitive = true
        type = string
}
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
# Profile variable definition
variable "profile" {
        default = "default"
        type = string
}
# Name variable definition
variable "instance_name" {
        default = "CrowdSec"
        type = string
}
# Subnet variable definition
variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-a5a72ce8"
        type = string
}
# Security-group-ids variable definition
variable "security_group_ids" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "sg-08ed5268bfc2d63a3"
        type = string
}
# Number of instances variable definition
variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}