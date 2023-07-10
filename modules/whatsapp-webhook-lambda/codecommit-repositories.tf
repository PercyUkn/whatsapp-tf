resource "aws_codecommit_repository" "whatsapp_webhook" {
  repository_name = "whatsapp-webhook"
  description     = "Repositorio para la lambda del WhatsApp Webhook"
  tags = {
    "createdBy" : "terraform"
  }
}
