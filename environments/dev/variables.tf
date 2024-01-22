variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  default     = "dev"
}

# variable "regions" {
#   description = "List of AWS regions"
#   type        = list(string)
#   default     = ["eu-west-1", "eu-central-1"]
# }

variable "availability_zones" {
  description = "Number of availability zones per region"
  type        = number
  default     = 2
}

variable "instance_count" {
  description = "Number of instances to create per availability zone"
  type        = number
  default     = 1
}

variable "ami" {}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_pair" {}