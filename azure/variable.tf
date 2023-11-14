variable "name" {
  type    = string
  default = "test-tf"
}
variable "subscription_id" {
  type    = string
  default = "subscription_id"
}
variable "resource_group" {
  type    = string
  default = "resource_group"
}
variable "gateway_id" {
  type    = string
  default = "TestAppGateway"
}
variable "certificate_name" {
  type    = string
  default = "certificate_name"
}
variable "region" {
  type    = string
  default = "westus2"
}
variable "vnet" {
  type    = string
  default = "vnet"
}
variable "instance_id" {
  type    = string
  default = "instance_id"
}
# HARNESS Variables
variable "account_id" {
  type    = string
  default = "wOSgd9G8SuajZo1dISEF2g"
}
variable "cloud_connector_id" {
  type    = string
  default = "Lightwing_Non_Prod"
}
variable "api_key" {
  type    = string
  default = "Set the env variable TF_VAR_api_key"
}

locals {
  tags = {
    lb_hostname = "${var.name}.lightwingtest.com"
  }
}
