locals {
  bucket_name = "djdjueujdj12344"
}

resource "aws_s3_bucket" "devops" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# resource "aws_s3_bucket" "devops1" {
#   bucket = var.bucket_name
#
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev2"
#   }
# }
#
# resource "aws_s3_bucket" "devos12" {
#   bucket = var.bucket_name
#
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }
#
# resource "aws_s3_bucket" "developer" {
#   bucket = var.bucket_name
#
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }
#
# resource "aws_s3_bucket" "developer1" {
#   bucket = local.bucket_name
#
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }
#
# module "s3_bucket" {
#   source = "../s3-module" #local path
#
#   bucket_name = var.bucket_name
#   environment = "dev"
# }
#
# module "s3-bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "4.6.0"
#
#   bucket = var.bucket_name
# }