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

### Challenges
I decided to upload the project to github directly from the command line and there was a learning curve to it.  
**The challenges included**
- Large files - These were files created by terraform init in my local directory for the project. adding the directory to .gitignore will have prevented this since they did not need to be uploaded to github.  
To resolve this, I deleted the large files but was still unable to commit the files to github. Now I understand that the issue was that the files were already in the staging area and I needed to remove it. Instead, the solution that worked for me at the time was to create a new temporary branch, add my files to the new branch, delete the old branch, rename the temporary branch and make the temporary branch the main. Thereafter, I was able to commit the files.
- Modules with .git directory - Because I used a module (vpc module) in this project, I had to upload as a submodule. This is because it was linked to the repository of origin. Git gave clue of how to resolved this which was to upload it as a submodule. 

**After this, I took the _Git Tutorial for Beginners: Learn Git in 1 Hour_ by Mosh on youtube to better understand git.**
