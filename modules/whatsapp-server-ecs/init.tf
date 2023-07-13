## Modules ##########################
module "global" {
  source = "../../global"
}

## Local variables ##################
locals {
  env         = terraform.workspace
  app_name        = "whatsapp-server"

  aws_region = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  aws_access_key_id = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  aws_secret_access_key = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  email_subscriber = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  load_balancer_vpc_id = {
    # Cambiar por el ID de la VPC
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  whatsapp_webhook_token = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  imgur_client_id = {
    # Cambiar por el ID de IMGUR
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  meta_id_number = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  meta_token = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  webhook_token = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  cantidad_clientes_iniciales = {
    "dev" = "1"
    "qa"  = ""
    "prd" = ""
  }

}
