terraform {
  required_providers {
    harness = {
      source = "harness/harness"
      version = "0.28.3"
    }
  }
}
provider "harness" {
  account_id       = var.account_id
  platform_api_key = var.api_key
}