#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  region  = var.region_secondary
  profile = var.profile
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 1.0.9"

  required_providers {
    aws = "~> 3.27"
  }

  backend "s3" {
    key = "root/security-monitoring-dr/terraform.tfstate"
  }
}
