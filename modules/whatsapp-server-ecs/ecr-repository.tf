# Create an ECR repository

resource "aws_ecr_repository" "whatsapp_server" {
  name = "${local.app_name}-ecr-repository"
}
