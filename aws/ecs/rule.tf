resource "harness_autostopping_aws_alb" "harness_alb" {
  name                   = "${var.name}EcsAppLB"
  cloud_connector_id     = var.cloud_connector_id
  host_name              = "ecs.${local.tags.lb_hostname}"
  alb_arn                = aws_lb.alb.arn
  region                 = var.region
  vpc                    = var.vpc
  security_groups        = [aws_security_group.http.id]
  route53_hosted_zone_id = var.hostedzone
}

resource "harness_autostopping_rule_ecs" "rule" {
    name = "${var.name} ECS Demo"  
    cloud_connector_id = var.cloud_connector_id
    idle_time_mins = 10              

    custom_domains = ["ecsrule.${local.tags.lb_hostname}"]
    
    container {
        cluster = "${var.name}SampleAppCluster"
        service = "${var.name}sample-httpd-app"
        region = var.region
        task_count = 1
    }		

    http {
        proxy_id = harness_autostopping_aws_alb.harness_alb.identifier             
    }
       
}