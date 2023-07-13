# Create an ECR repository

resource "aws_ecr_repository" "whatsapp_webhook" {
  name         = "${local.app_name}-ecr-repository"
  force_delete = true
}

resource "null_resource" "pull_and_push_image" {
  depends_on = [aws_ecr_repository.whatsapp_webhook]

  provisioner "local-exec" {
    command = <<EOT
      echo "Pulling the lightest image from Docker Hub..."
      docker pull alpine:latest

      echo "Tagging the pulled image with the ECR repository URI..."
      echo "ECR Repository: ${aws_ecr_repository.whatsapp_webhook.repository_url}"
      docker tag alpine:latest ${aws_ecr_repository.whatsapp_webhook.repository_url}:latest

      echo "Authenticating with the ECR registry using the AWS CLI..."
      aws ecr get-login-password --region ${local.aws_region[local.env]} | docker login --username AWS --password-stdin ${aws_ecr_repository.whatsapp_webhook.repository_url}

      echo "Pushing the image to the ECR repository..."
      docker push ${aws_ecr_repository.whatsapp_webhook.repository_url}:latest

      echo "Removing the locally pulled image..."
      docker rmi alpine:latest ${aws_ecr_repository.whatsapp_webhook.repository_url}:latest
    EOT
  }
}
