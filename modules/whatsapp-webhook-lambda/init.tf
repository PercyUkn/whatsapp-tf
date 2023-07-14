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
