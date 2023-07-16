# Output the public URL of the Lambda function

output "lambda_url" {
  value = aws_lambda_function_url.whatsapp_webhook_lambda_url.function_url
}

output "lambda_cc_repo_url" {
  value = aws_codecommit_repository.whatsapp_webhook.clone_url_http
}
