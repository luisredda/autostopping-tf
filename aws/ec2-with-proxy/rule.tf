
# Expects aws/proxy to be executed before executing this
# Setting up a rule with HTTP and SSH as the access pattern
resource "harness_autostopping_rule_vm" "rule" {
  name               = "${var.name}-ec2-rule-with-proxy"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins     = 5
  filter {
    vm_ids  = [aws_instance.ec2.id]
    regions = [var.region]
  }
  http {
    proxy_id = var.proxy_id
    routing {
      source_protocol = "http"
      target_protocol = "http"
      source_port     = 80
      target_port     = 80
      action          = "forward"
    }
    health {
      protocol         = "http"
      port             = 80
      path             = "/"
      timeout          = 30
      status_code_from = 200
      status_code_to   = 299
    }
  }
  tcp {
    proxy_id = var.proxy_id
    forward_rule {
      port = 22
    }
  }
  custom_domains = [ "${var.proxy_public_ip}.nip.io"]
}