resource "aws_ecs_task_definition" "service" {
  family = "${var.name}EcsSampleApp"
  container_definitions = jsonencode([
    {
      name      = "${var.name}SampleApp"
      image     = "public.ecr.aws/docker/library/httpd:latest"
      cpu       = 0
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          name          = "sample-app-80-tcp"
          protocol      = "tcp"
        }
      ],
      entryPoint = [
        "sh",
        "-c"
      ],
      command = [
        "/bin/sh -c \"echo '<html> <head> <title>ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>You are all set to AutoStop</h2> <p>This application is running on a container in Amazon ECS.</p> </div></body></html>' > /usr/local/apache2/htdocs/index.html && httpd-foreground\""
      ],
      mountPoints = [],
      volumesFrom = []
    }
  ])
  execution_role_arn = var.task_exec_role
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 1024
  memory = 2048

}
resource "aws_security_group" "http" {
  name        = "${var.name}SampleEcsAppSG"
  description = "Security group for whitelisting ports required for EcsSampleApp"
  vpc_id      = var.vpc

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}default"
  }
}
resource "aws_ecs_service" "sampleapp" {
  name            = "${var.name}sample-httpd-app"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"
  network_configuration {
    subnets = var.subnets
    security_groups = [aws_security_group.http.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.http.arn
    container_name   = "${var.name}SampleApp"
    container_port   = 80
  }
}