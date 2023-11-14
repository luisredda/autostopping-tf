terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.28.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "harness" {
  account_id       = var.account_id
  platform_api_key = var.api_key
}

provider "aws" {
  region = var.region
}
