resource "harness_autostopping_aws_alb" "harness_alb" {
  name                   = "${var.name}-lb"
  cloud_connector_id     = var.cloud_connector_id
  host_name              = local.tags.lb_hostname
  alb_arn                = aws_lb.alb.arn
  region                 = var.region
  vpc                    = var.vpc
  security_groups        = [aws_security_group.http.id]
  route53_hosted_zone_id = var.hostedzone
}
resource "harness_autostopping_rule_vm" "rule" {
  name               = "${var.name}-ec2-rule"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins     = 5
  filter {
    vm_ids  = [aws_instance.ec2.id]
    regions = [var.region]
  }
  http {
    proxy_id = harness_autostopping_aws_alb.harness_alb.identifier
    routing {
      source_protocol = "http"
      target_protocol = "http"
      source_port     = 80
      target_port     = 8080
      action          = "forward"
    }
    health {
      protocol         = "http"
      port             = 8080
      path             = "/"
      timeout          = 30
      status_code_from = 200
      status_code_to   = 299
    }
  }
  custom_domains = [ "ec2rule.${local.tags.lb_hostname}"]
}
