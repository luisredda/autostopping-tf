### Terraform Commands
```shell
terraform init
terraform plan
terraform apply
```

### How to use this terraform playbook?
Replace the variables in `variable.tf` file and then run the terraform commands listed above. This will:
1. Provision an ec2 machine with nginx insalled
2. Provision an ALB and create a rule for routing to the VM
3. Create a Harness Lb with the ALB
4. Create an AutoStopping Rule for the VM

##### I already have an ALB
1. Comment out the section for alb in `alb.tf` (starting with`resource "aws_lb" "alb"`)
2. Replace `aws_lb.alb.arn` with your ALBs ARN