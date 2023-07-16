# Create an ECR repository

resource "aws_ecr_repository" "whatsapp_server" {
  name = "${var.app_name}-ecr-repository"
  force_delete = true
}
