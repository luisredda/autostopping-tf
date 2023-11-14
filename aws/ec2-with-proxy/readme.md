### Terraform Commands
```shell
terraform init
terraform plan
terraform apply
```

### How to use this terraform playbook?
Replace the variables in `variable.tf` file and then run the terraform commands listed above. This will:
1. Provision an ec2 machine with nginx insalled
2. Create an AutoStopping Rule for the VM and add it under the specified proxy
