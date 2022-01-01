terraform {
   backend "s3" {
     bucket = "udacity-tf-lekhraj-zone1"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
     profile = "udacity"
   }
 }

 provider "aws" {
   region = "us-east-2"
   
   default_tags {
     tags = local.tags
   }
   profile = "udacity"
 }

 provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
  profile = "udacity"
}