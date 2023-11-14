### Terraform Commands
```shell
terraform init
terraform plan
terraform apply
```

### How to use this terraform playbook?
Replace the variables in `variable.tf` file and then run the terraform commands listed above. This will:
1. Provision an ecs cluster
2. Deploy a sample service to the cluster
3. Create an ALB and loadbalance to the service
4. Create a Harness LB by importing the load balancer
5. Create an AutoStopping Rule for the ECS Service

#### I already have an ECS cluster
1. Comment out `ecs.tf` file and replace the `aws_ecs_cluster.foo.id` with your ecs arn in `sample.tf`

#### I already have an ALB
1. Comment out the section for alb in `alb.tf` (starting with`resource "aws_lb" "alb"`)
2. Replace `aws_lb.alb.arn` with your ALBs ARN