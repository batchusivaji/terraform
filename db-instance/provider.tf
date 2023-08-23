
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">=1.4.0"
  #backend "s3" {
  #  bucket = "qt-bucket"
  #  key = "aws/terraform/qt"
  #  region = "us-west-2"
  #  dynamodb_table = "terraformlock"
  #}
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
} 
