variable "name" {
  type    = string
  default = "<replace with your name>"  
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
variable "ami" {
  type    = string
  default = "ami-0efcece6bed30fd98"
}
variable "hostedzone" {
  type    = string
  default = "/hostedzone/Z2X614CI8JN37A"
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
