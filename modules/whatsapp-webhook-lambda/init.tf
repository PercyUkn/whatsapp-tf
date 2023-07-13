## Modules ##########################
module "global" {
  source = "../../global"
}

## Local variables ##################
locals {
  env         = terraform.workspace
  app_name        = "whatsapp-webhook"

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
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  whatsapp_webhook_token = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

  whatsapp_server_url = {
    "dev" = ""
    "qa"  = ""
    "prd" = ""
  }

}
