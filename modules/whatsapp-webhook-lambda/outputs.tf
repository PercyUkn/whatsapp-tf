# Output the public URL of the Lambda function

output "lambda_url" {
  value = aws_lambda_function.whatsapp_webhook_lambda.invoke_arn
}

output "lambda_cc_repo_url" {
  value = aws_codecommit_repository.whatsapp_webhook.clone_url_http
}
