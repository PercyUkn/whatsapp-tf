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

module "whatsapp-server-ecs" {
  source                      = "./modules/whatsapp-server-ecs"
}

module "whatsapp-webhook-lambda" {
  source                 = "./modules/whatsapp-webhook-lambda"
  whatsapp_server_url    = module.whatsapp-server-ecs.whatsapp_server_lb_dns_name
}
