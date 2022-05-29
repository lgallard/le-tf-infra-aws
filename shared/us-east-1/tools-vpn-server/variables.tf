#
# config/backend.config
#
#================================#
# Terraform AWS Backend Settings #
#================================#
variable "region" {
  type        = string
  description = "AWS Region"
}

variable "profile" {
  type        = string
  description = "AWS Profile (required by the backend but also used for other resources)"
}

variable "bucket" {
  type        = string
  description = "AWS S3 TF State Backend Bucket"
}

variable "dynamodb_table" {
  type        = string
  description = "AWS DynamoDB TF Lock state table name"
}

variable "encrypt" {
  type        = bool
  description = "Enable AWS DynamoDB with server side encryption"
}

#
# config/base.config
#
#=============================#
# Project Variables           #
#=============================#
variable "project" {
  type        = string
  description = "Project Name"
}

variable "project_long" {
  type        = string
  description = "Project Long Name"
}

variable "environment" {
  type        = string
  description = "Environment Name"
}

#
# config/extra.config
#
#=============================#
# Accounts & Extra Vars       #
#=============================#
variable "region_secondary" {
  type        = string
  description = "AWS Scondary Region for HA"
}

variable "accounts" {
  type        = any
  description = "Accounts IDs and Emails"
}

#=============================#
# EC2 BASIC LAYOUT MODULE     #
#=============================#
#
# General
#
variable "prefix" {
  type        = string
  description = "Prefix"
  default     = "infra"
}

variable "name" {
  type        = string
  description = "Name"
  default     = "vpn-pritunl"
}

#
# EC2 Attributes
#
variable "aws_ami_os_id" {
  description = "AWS AMI Operating System Identificator"
  default     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}

variable "aws_ami_os_owner" {
  description = "AWS AMI Operating System Owner, eg: 099720109477 for Canonical "
  default     = "099720109477"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t3.micro"
}

variable "ebs_optimized" {
  type        = string
  description = "Enable EBS Optimized"
  default     = "false"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = true
}

variable "root_device_backup_tag" {
  type        = string
  description = "EC2 Root Block Device backup tag"
  default     = "True"
}

variable "monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "tag_approved_ami_value" {
  type        = string
  description = "Set the specific tag ApprovedAMI ('true' | 'false') that identifies aws-config compliant AMIs"
  default     = "true"
}

#=============================#
# Hashicorp Vault Vars        #
#=============================#
variable "vault_address" {
  type        = string
  description = "Hashicorp vault api endpoint address"
}

variable "vault_token" {
  type        = string
  description = "Hashicorp vault admin token"
}
