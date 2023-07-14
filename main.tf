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
  aws_access_key_id           = var.aws_access_key_id
  aws_secret_access_key       = var.aws_secret_access_key
  email_subscriber            = var.email_subscriber
  load_balancer_vpc_id        = var.load_balancer_vpc_id
  imgur_client_id             = var.imgur_client_id
  meta_id_number              = var.meta_id_number
  meta_token                  = var.meta_token
  webhook_token               = var.webhook_token
  cantidad_clientes_iniciales = var.cantidad_clientes_iniciales
}

module "whatsapp-webhook-lambda" {
  source                 = "./modules/whatsapp-webhook-lambda"
  aws_access_key_id      = var.aws_access_key_id
  aws_secret_access_key  = var.aws_secret_access_key
  whatsapp_webhook_token = var.webhook_token
  whatsapp_server_url    = "http://${module.whatsapp-server-ecs.whatsapp_server_lb_dns_name}/api/webhook"
}
