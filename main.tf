# Providers

variable "aws_access_key"
{}
variable "aws_secret_key"
{}
variable "workspace"
{}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

# Backend

terraform {
  required_version = ">=0.11.0"

  backend "s3" {
   bucket = "cv-terraform-backend"
   key = "python_hello_world/terraform.tfstate"
   region = "us-east-1"


   dynamodb_table = "cv-terraform-state"
   workspace_key_prefix = "terraform-state"

 }
}

### Terraform linked projects ###

data "terraform_remote_state" "config" {
  backend = "s3"
  config {
    bucket = "cv-terraform-backend"
    key    = "terraform-state/${var.workspace}-config/config/terraform.tfstate"
    region = "us-east-1"
  }
}
