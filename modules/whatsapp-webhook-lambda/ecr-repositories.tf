# Create an ECR repository

resource "aws_ecr_repository" "whatsapp_webhook" {
  name         = "${var.app_name}-ecr-repository"
  force_delete = true


}

resource "null_resource" "pull_and_push_image" {
  depends_on = [aws_ecr_repository.whatsapp_webhook]

  provisioner "local-exec" {
    command = <<EOT
      docker pull alpine:latest && docker tag alpine:latest ${aws_ecr_repository.whatsapp_webhook.repository_url}:latest && aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.whatsapp_webhook.repository_url}&& docker push ${aws_ecr_repository.whatsapp_webhook.repository_url}:latest&& docker rmi alpine:latest ${aws_ecr_repository.whatsapp_webhook.repository_url}:latest
    EOT
  }
}
