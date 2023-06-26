terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">=4.36.0, <4.47.0, !=4.43.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}


provider "aws" {
  region     = "us-east-1"
  access_key = var.acces_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}

