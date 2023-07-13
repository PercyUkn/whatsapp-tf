resource "aws_codecommit_repository" "whatsapp_webhook" {
  repository_name = "${local.app_name}-repository-tf"
  description     = "Repositorio para la lambda del WhatsApp Webhook"
  tags = {
    "createdBy" : "terraform"
  }
}
