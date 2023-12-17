# # main.tf

# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_s3_bucket" "tf_backend_bucket" {
#   bucket = "your-unique-tf-backend-bucket-name"
#   acl    = "private"
#   # Add other bucket settings as needed
# }

# resource "aws_dynamodb_table" "tf_lock_table" {
#   name           = "your-unique-tf-lock-table-name"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# terraform {
#   backend "s3" {
#     bucket         = aws_s3_bucket.tf_backend_bucket.bucket
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = aws_dynamodb_table.tf_lock_table.name
#   }
# }
