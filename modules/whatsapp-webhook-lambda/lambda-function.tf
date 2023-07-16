resource "aws_lambda_function" "whatsapp_webhook_lambda" {
  function_name = "${var.app_name}-lambda-tf" # Update with your desired Lambda function name
  role          = aws_iam_role.whatsapp_webhook_lambda_role.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.whatsapp_webhook.repository_url}:latest"
  publish       = true

  environment {
    variables = {
      WHATSAPP_TOKEN      = var.whatsapp_webhook_token
      WHATSAPP_SERVER_URL = var.whatsapp_server_url
    }
  }

}

resource "aws_lambda_function_url" "whatsapp_webhook_lambda_url" {
  function_name      = aws_lambda_function.whatsapp_webhook_lambda.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}
