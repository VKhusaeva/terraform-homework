provider aws {
     region = "us-east-2"
 }

# resource "aws_key_pair" "deployer" {
#   key_name   = "Bastion-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# resource "aws_s3_bucket" "example" {
#   bucket = "kaizen-viktoria222"   
# }

# resource "aws_s3_bucket" "example1" {
# bucket_prefix = "kaizen-"
# }

# resource "aws_s3_bucket" "manual1" {
#   bucket = "my-buckethello1"   
# }

# resource "aws_s3_bucket" "manual2" {
#   bucket = "my-buckethello2"   
# }

# # terraform import aws_s3_bucket.manual1 my-buckethello1
# # terraform import aws_s3_bucket.manual2 my-buckethello2