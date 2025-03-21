terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "devops123abctech"
    key = "devops/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}


resource "aws_s3_bucket" "devops" {
  bucket = "test1234abc123c12"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
