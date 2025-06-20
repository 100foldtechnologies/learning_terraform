provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "developer1" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
  }
}