provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Name = "app"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.1"
    }
  }
}
