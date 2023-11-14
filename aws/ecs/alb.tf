resource "aws_lb" "alb" {
  name               = "${var.name}EcsAppLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http.id]
  subnets            = var.subnets

}
resource "aws_lb_target_group" "http" {
  name     = "${var.name}ecs-sample-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc
  target_type = "ip"
}
resource "aws_lb_listener" "ecs" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}