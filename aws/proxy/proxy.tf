# Create a proxy vm with a public IP
resource "harness_autostopping_aws_proxy" "rdsconnectproxy" {
  name                   = "${var.name}-proxy"
  cloud_connector_id     = var.cloud_connector_id
  host_name              = "${var.name}.autostopping.lightwingtest.com"
  region                 = var.region
  vpc                    = var.vpc
  security_groups        = [aws_security_group.sgforproxy.id]
  route53_hosted_zone_id = var.hostedzone
  machine_type           = "t3.micro"
  api_key                = var.api_key
  allocate_static_ip     = false
}
