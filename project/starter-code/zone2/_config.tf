terraform {
   backend "s3" {
     bucket = "udacity-tf-lekhraj-zone2"
     key    = "terraform/terraform.tfstate"
     region = "us-west-1"
     profile = "udacity"
   }
 }

 provider "aws" {
   region = "us-west-1"
   profile = "udacity"
   
   default_tags {
     tags = local.tags
   }
 }