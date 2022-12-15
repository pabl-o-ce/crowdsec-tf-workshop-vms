![CrowdSec](https://app.crowdsec.net/vectors/crowdsec.svg "CrowdSec Logo")

# Crowdsec Terraform for workshops

## Cloud provider

- **mio_cloud_provider_attacker** set in [__***terraform.tfvars***__] file
- **mio_cloud_provider_defender** set in [__***terraform.tfvars***__] file
- **mio_dns_provider** set in [__***terraform.tfvars***__] file
- **mio_user_data_path** set in [__***terraform.tfvars***__] file
- **mio_number_users** set in [__***terraform.tfvars***__] file

## AWS

- **aws_access_key:** set in [__***terraform.tfvars***__] file
- **aws_secret_key:** set in [__***terraform.tfvars***__] file
- **aws_region:** set in [__***terraform.tfvars***__] file
- **aws_instance_type:** set in [__***terraform.tfvars***__] file
- **aws_image_attacker:** set in [__***terraform.tfvars***__] file
- **aws_image_defender:** set in [__***terraform.tfvars***__] file
- **aws_key_name:** set in [__***terraform.tfvars***__] file
- **aws_security_group_ids:** set in [__***terraform.tfvars***__] file
- [**API docs**](https://docs.aws.amazon.com/)

## Cloudflare

- **cf_token:** set in [__***terraform.tfvars***__] file
- **cf_zone_id:** set in [__***terraform.tfvars***__] file
- [**API docs**](https://api.cloudflare.com/)

## Digital Ocean

- **do_token:** set in [__***terraform.tfvars***__] file
- **do_region:** set in [__***terraform.tfvars***__] file
- **do_instance_type:** set in [__***terraform.tfvars***__] file
- **do_image_attacker:** set in [__***terraform.tfvars***__] file
- **do_image_defender:** set in [__***terraform.tfvars***__] file
- [**API docs**](https://docs.digitalocean.com/reference/api/api-reference/)

## TransIP

- **private_key:** need to be generated as file with name transip.pem
- **tsp_account:** set in [__***terraform.tfvars***__] file
- **tsp_region:** = set in [__***terraform.tfvars***__] file
- **tsp_instance_type:** set in [__***terraform.tfvars***__] file
- **tsp_image_attacker:** set in [__***terraform.tfvars***__] file
- **tsp_image_defender:** set in [__***terraform.tfvars***__] file
- **tsp_domain:** set in [__***terraform.tfvars***__] file
- [**API docs**](https://api.transip.nl/rest/docs.html)

## Setup

Once you get the keys you need to create and define terraform.tfvars:

```
touch ./terraform.tfvars
```

Add variables:

```sh
echo -e "#####     Cloud Provider     #####
# options: aws | do | tsp
mio_cloud_provider_attacker = \"<aws | do | tsp>\"
mio_cloud_provider_defender = \"<aws | do | tsp>\"
# options: cf | tsp
mio_dns_provider = \"<cf | tsp>\"
mio_user_data_path = \"./user-data\"
mio_number_users = 1
#####     AWS     #####
aws_access_key = \"<accessKey>\"
aws_secret_key = \"<secretKey>\"
aws_region = \"<region>\"
aws_instance_type = \"<instanceType>\"
aws_image_attacker = \"<amiId>\"
aws_image_defender = \"<amiId>\"
aws_key_name = \"<keyName>\"
aws_security_group_ids = \"<securityGroupIds>\"
#####     Cloudflare     #####
cf_token = \"<cf_token>\"
cf_zone_id = \"<cf_zone_id>\"
#####     TransIP     #####
tsp_account = \"<tsp_account>\"
tsp_region = \"<rtm0>\"
tsp_instance_type = \"<vps-bladevps-xs>\"
tsp_image_attacker = \"<tsp_attacker_image = ubuntu-22.04>\"
tsp_image_defender = \"<tsp_defender_image = ubuntu-22.04>\"
tsp_domain = \"<tsp_domain>\"
#####     Digital Ocean     #####
do_token = \"<do_token>\"
do_region = \"<do_region>\"
do_instance_type = \"<do_instance_type>\"
do_image_attacker = \"<do_attacker_image>\"
do_image_defender = \"<do_defender_image>\"" > ./terraform.tfvars
```

### Terraform

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
terraform output -json crowdsec_workshop | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' > output.csv
```

Using `jsonv`

```
terraform output -json crowdsec_workshop | jsonv dns,public_ip > output.csv
```
