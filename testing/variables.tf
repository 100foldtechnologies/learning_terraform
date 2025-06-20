variable "vpc_cidr_block" {
  description = "my cidr block for vpc"
}

variable "my_subnet_cidr_block" {
  description = ""
  default = "10.0.1.0/24"
}

variable "region" {}