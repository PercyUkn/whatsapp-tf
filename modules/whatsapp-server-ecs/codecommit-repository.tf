resource "aws_codecommit_repository" "whatsapp_server" {
  repository_name = "${var.app_name}-tf"
  description     = "Repositorio para WhatsApp Server desplegado en ECS"
  tags = {
    "createdBy" : "terraform"
  }
}
