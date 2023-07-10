terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


module "whatsapp-webhook-lambda" {
  source = "./modules/whatsapp-webhook-lambda"
  aws_access_key_id      = var.aws_access_key_id
  aws_secret_access_key  = var.aws_secret_access_key
  whatsapp_webhook_token = var.whatsapp_webhook_token
}
