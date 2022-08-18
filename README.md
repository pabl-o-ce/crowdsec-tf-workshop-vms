![CrowdSec](https://app.crowdsec.net/vectors/crowdsec.svg "CrowdSec Logo") 
# Crowdsec Terraform for workshops
## AWS
- **aws_region:** set in [__***terraform.tfvars***__] file
- **access_key:** set in [__***terraform.tfvars***__] file
- **secret_key:** set in [__***terraform.tfvars***__] file
- **ami_id:** set in [__***terraform.tfvars***__] file
- **instance_type:** set in [__***terraform.tfvars***__] file
- **key_name:** set in [__***terraform.tfvars***__] file
- **security_group_ids:** set in [__***terraform.tfvars***__] file
- **aws_number_of_instances:** set in [__***variables.tf***__] file
- **user_data:** https://github.com/klausagnoletti/cloud-init
## Cloudflare
- **cf_zone_id:** set in [__***terraform.tfvars***__] file
- **cf_token:** set in [__***terraform.tfvars***__] file
## TransIP
- **tsp_account:** set in [__***terraform.tfvars***__] file
- **tsp_key:** set in [__***terraform.tfvars***__] file
- **tsp_type:** set in [__***terraform.tfvars***__] file
- **tsp_image_attacker:** set in [__***terraform.tfvars***__] file
- **tsp_image_defender:** set in [__***terraform.tfvars***__] file
- **tsp_azone:** = set in [__***terraform.tfvars***__] file
- **tsp_number_of_instances:** set in [__***variables.tf***__] file
- **install_text:** https://github.com/klausagnoletti/cloud-init

## Setup
### Get Credentials Access from the cloud provider you want to use
Once you get the keys you need to create and define terraform.tfvars:
```
touch ./terraform.tfvars
```
Add variables:
```sh
echo -e "#####     Cloud Provider     #####
cloud_provider = \"<aws || tsp>\"
dns_provider = \"<cf || tsp>\"
#####     AWS     #####
aws_number_of_instances = \"<aws_number_instances>\"
aws_access_key = \"<accessKey>\"
aws_secret_key = \"<secretKey>\"
aws_region = \"<region>\"
aws_key_name = \"<keyName>\"
aws_ami_attack = \"<amiId>\"
aws_ami_defense = \"<amiId>\"
aws_instance_type = \"<instanceType>\"
aws_security_group_ids = \"<securityGroupIds>\"
#####     Cloudflare     #####
cf_zone_id = \"<cf_zone_id>\"
cf_token = \"<cf_token>\"
#####     TransIP     #####
tsp_number_of_instances = \"<tsp_number_instances>\"
tsp_account = \"<tsp_account>\"
tsp_key = \"<tsp_key>\"
tsp_type = \"<tsp_instance_type>\"
tsp_image_attacker = \"<tsp_attacker_image>\"
tsp_image_defender = \"<tsp_defender_image>\"
tsp_azone = \"<tsp_available_zone>\"" > ./terraform.tfvars
```
### Terraform configuration files
#### Init Terraform
```sh
terraform init
```
#### Check Terraform
```sh
terraform plan --auto-approve
```
#### Create Terraform
```sh
terraform apply -var-file="terraform.tfvars" --auto-approve
```
#### Delete using Terraform
```sh
terraform destroy --auto-approve
```
#### Output to CSV file
Using `jq`
```
terraform output -json crowdsec_workshop_list | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' > output.csv
```
Using `jsonv`
```
terraform output -json crowdsec_workshop_list | jsonv dns,public_ip > output.csv
```
