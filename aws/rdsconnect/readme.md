### Terraform Commands
```shell
terraform init
terraform plan
terraform apply
```

### How to use this terraform playbook?
Replace the variables in `variable.tf` file and then run the terraform commands listed above. This will:
1. Provision an RDS instance
2. Create an AutoStopping Rule for the RDS under the configured proxy

##### I already have an RDS
1. Comment out `rds.tf`
2. Replace `aws_db_instance.rds.arn` in `rule.tf` with your RDSs ARN