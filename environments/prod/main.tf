terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"  # Specific to your production environment
}

module "vpc" {
  source = "../modules/vpc"
  environment = var.environment
  vpc_cidr          = "10.0.0.0/16"
  availability_zones = ["eu-central-1a", "eu-central-1b"]
  region = var.region
  
}

module "instance" {
  source        = "../modules/instance"
  environment   = var.environment
  regions       = ["eu-central-1"]
  availability_zones = 2
  instance_count = 1
  key_pair = var.key_pair
  ami = var.ami
}
