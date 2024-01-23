terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"  # Specific to your development environment
}

module "vpc" {
  source = "/home/ubuntu/terraform-modules/modules/vpc"
  environment = "dev"
  vpc_cidr          = "10.0.0.0/16"
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  region            = var.region
}

module "instance" {
  source        = "/home/ubuntu/terraform-modules/modules/instance"
  environment   = "dev"
  region        = ["eu-west-1"]
  availability_zones = 2
  instance_count = 1
  key_pair = var.key_pair
  ami = var.ami
  vpc_id = var.vpc_id
}
