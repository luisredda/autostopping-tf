
# Create RDS AutoStopping rule
resource "harness_autostopping_rule_rds" "test" {
  name               = "${var.name}-db"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins     = 30
  database {
    id     = aws_db_instance.rds.arn
    region = var.region
  }

  tcp {
    proxy_id = var.proxy_id
    forward_rule {
      port = var.rds_port
    }
  }
}