# Create an ECR repository

resource "aws_ecr_repository" "whatsapp_webhook" {
  name = "whatsapp-webhook-ecr-repository"
}
