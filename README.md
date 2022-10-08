### Globo Web App
This project was carried out by following along and doing the exercises in  the course "Terraform - Getting Started" by Ned Ballavance on Pluralsight.


### Summary of the App
This is a simple website running on nginx. The app is loadbalanced across 2 EC2 instances for redundancy

### Key features

1. Harshicorp vpc module used to configure the VPC
2. S3 module created manually
3. Use of terraform.tfvars to create static variables
4. Use workspaces to create multiple environments that use the same code
5. Use of variables in accordance with the DRY (Don't Repeat Yourself) principle
6. Use random integers in creating unique S3 bucket names.
7. create IAM roles
8. Upload objects into a dynamically created bucket


### Testing
To test this app, you will need the following.

- A free-tier eligible AWS Account.
- An IAM user with permissions to create the elements of this architecture.
- add the access keys of the IAM to your environment variables using
- Terraform installed on your computer 

### Commands
### To access the AWS environment
```
export AWS_ACCESS_KEY_ID="ACCESS KEY ID"
export AWS_SECRET_ACCESS_KEY="SECRET KEY"
```

### To run the app
```
terraform init
terraform validate
terraform workspace new Development ** there are 3 workspace environments possible. The Development workspace is free tier eligible. See /Globo-Terraform-Project/globo_web_app/terraform.tfvars for the workspace names. **
terraform plan -out "dev_test.tfplan"
terraform apply "dev_test.tfplan"
```
**Thereafter, the app will provide you with the DNS domain of the ELB**

### When you are done evaluating the app, you can remove it from your AWS account using 
```
terraform destroy -auto-approve
```
