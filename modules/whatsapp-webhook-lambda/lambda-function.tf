resource "aws_lambda_function" "whatsapp_webhook_lambda" {
  function_name = "${local.app_name}-lambda-tf" # Update with your desired Lambda function name
  role          = aws_iam_role.whatsapp_webhook_lambda_role.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.whatsapp_webhook.repository_url}:latest"
  publish       = true

  environment {
    variables = {
      WHATSAPP_TOKEN      = local.whatsapp_webhook_token[local.env]
      # Este campo es dependiente
      WHATSAPP_SERVER_URL = var.whatsapp_server_url
    }
  }

}
