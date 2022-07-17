![CrowdSec](https://app.crowdsec.net/vectors/crowdsec.svg "CrowdSec Logo") 
# Crowdsec Terraform in AWS for workshops
## Vars
- **region:** us-east-1 (need to set region)
- **image-id:** ami-0245697ee3e07e755
- **instance-type:** t2.nano, t2.micro
- **security-group-ids:** sg-08ed5268bfc2d63a3
- **key-name:** MyEC2KeyPair
- **user-data (sshbg):** https://github.com/klausagnoletti/cloud-init
- **number_of_instances:** 1

## Setup
### Get AWS Credentials Access key and Secret Key
Once you get the keys you need to create and define terraform.tfvars
```sh
echo "ami_id = \"<amiId>\"
access_key = \"<accessKey>\"
secret_key = \"<secretKey>\"
credentials_path = \"~/User_Name/.aws/credentials\"
aws_region = \"<region>\"
instance_type = \"<instanceType>\"" > ./terraform.tfvars
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
terraform plan
```
#### The third command to be used is 'terraform apply'
this command will create the resources on the AWS mentioned in the main.tf file.
You will be prompted to provide your input to create the resources.
```sh
terraform apply -var-file="terraform.tfvars"
```
#### Delete the created EC2 Instance using Terraform
If you no longer require resources you created using the configuration mentioned in the main.tf file, You can use the "terraform destroy" command to delete all those resources.
```sh
terraform destroy
```