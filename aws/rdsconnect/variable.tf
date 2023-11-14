variable "name" {
  type    = string
  default = "<replace with your name, no spaces>"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-682a8223", "subnet-e357d99a", "subnet-bef497e4"]
}

variable "vpc" {
  type    = string
  default = "vpc-51edc228"
}
variable "region" {
  type    = string
  default = "us-west-2"
}
variable "rds_arn" {
  type    = string
  default = "arn:aws:rds:us-east-1:357919113896:db:autostopping-rds"
}
variable "rds_port" {
  type    = number
  default = 3306
}
variable "proxy_id" {
  type    = string
  default = "ap-cl9ci0c259bkv48fjq30"
}
variable "hostedzone" {
  type    = string
  default = "/hostedzone/Z2X614CI8JN37A"
}
variable "dbuser" {
  type    = string
  default = "harness"
}
variable "dbcred" {
  type    = string
  default = "H$rn3ssTerraformTest"
}

# HARNESS Variables
variable "account_id" {
  type    = string
  default = "SAsyUUHTTImuYSZ35HPDvw"
}
variable "cloud_connector_id" {
  type    = string
  default = "SE_AWS_CCM_Connector"
}
variable "api_key" {
  type    = string
  default = "Set the env variable TF_VAR_api_key"
}

locals {
  tags = {
    lb_hostname = "${var.name}.tools.harnessio.se"
  }
}
