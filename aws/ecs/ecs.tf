resource "aws_ecs_cluster" "foo" {
  name = "${var.name}SampleAppCluster"
}