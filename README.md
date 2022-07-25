![CrowdSec](https://app.crowdsec.net/vectors/crowdsec.svg "CrowdSec Logo") 
# Crowdsec Terraform for workshops
## Variables for AWS
- **aws_region:** set in [<u>terraform.tfvars</u>] file
- **access_key:** set in [<u>terraform.tfvars</u>] file
- **secret_key:** set in [<u>terraform.tfvars</u>] file
- **ami_id:** set in [<u>terraform.tfvars</u>] file
- **instance_type:** set in [<u>terraform.tfvars</u>] file
- **key_name:** set in [<u>terraform.tfvars</u>] file
- **security_group_ids:** set in [<u>terraform.tfvars</u>] file
- **number_of_instances:** set in [<u>variables.tf</u>] file
- **user_data:** https://github.com/klausagnoletti/cloud-init

## Variables for Digital Ocean
- **key:**
## Variables for Oracle Cloud
- **key:**
## Variables for Linode
- **key:**
## Variables for TransIP
- **key:**

## Setup
### Get AWS Credentials Access key and Secret Key
Once you get the keys you need to create and define terraform.tfvars:
```
touch ./terraform.tfvars
```
Add variable for AWS:
```sh
echo -e "access_key = \"<accessKey>\"
secret_key = \"<secretKey>\"
aws_region = \"<region>\"
key_name = \"<keyName>\"
ami_attack = \"<amiId>\"
ami_defense = \"<amiId>\"
instance_type = \"<instanceType>\"
security_group_ids = \"<securityGroupIds>\"" > ./terraform.tfvars
```
### Create an EC2 Instance using the Terraform configuration files
#### The first command to be used is 'terraform init'.
This command downloads and installs plugins for providers used within the configuration. In our case it is AWS.
```sh
terraform init
```
#### The second command to be used is 'terraform plan'.
This command is used to see the changes that will take place on the infrastructure.
```sh
terraform plan --auto-approve
```
#### The third command to be used is 'terraform apply'
this command will create the resources on the AWS mentioned in the main.tf file.
You will be prompted to provide your input to create the resources.
```sh
terraform apply -var-file="terraform.tfvars" --auto-approve
```
#### Delete the created EC2 Instance using Terraform
If you no longer require resources you created using the configuration mentioned in the main.tf file, You can use the "terraform destroy" command to delete all those resources.
```sh
terraform destroy --auto-approve
```
