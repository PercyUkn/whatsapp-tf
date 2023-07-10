# Output the public URL of the Lambda function

output "lambda_url" {
  value = aws_lambda_function.whatsapp_webhook_lambda.invoke_arn
}
