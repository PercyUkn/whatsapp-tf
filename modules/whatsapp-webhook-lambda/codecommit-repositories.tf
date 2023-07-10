resource "aws_codecommit_repository" "whatsapp_webhook" {
  repository_name = var.app_name
  description     = "Repositorio para la lambda del WhatsApp Webhook"
  tags = {
    "createdBy" : "terraform"
  }
}
