variable "name" {
  type    = string
  default = "test-tf"
}
variable "cloud_connector_id" {
  type    = string
  default = "nknautostoptest"
}
locals {
  tags = {
    lb_hostname = "${var.name}.lightwingtest.com"
  }
}
variable "region" {
  type    = string
  default = "us-central1"
}
variable "zone" {
  type    = string
  default = "us-central1-a"
}
variable "gcp_project" {
  type    = string
  default = "ccm-play"
}
variable "network_id" {
  type    = string
  default = "default"
}
variable "subnetwork_id" {
  type    = string
  default = "default"
}
variable "api_key" {
  type    = string
  default = "Set the env variable TF_VAR_api_key"
}
variable "account_id" {
  type    = string
  default = "wOSgd9G8SuajZo1dISEF2g"
}
variable "instance_id" {
  type    = string
  default = "1257370280559427330"
}
