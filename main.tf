provider "aws" {
    region= var.aws_region
    # If use keys
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    # If you use own aws credentials paths e.d ~/User_Name/.aws/credentials
    # shared_credentials_file = "${var.credentials_path}"
    # profile= var.profile
}