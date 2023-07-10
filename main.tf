terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# Output the public URL of the Lambda function

output "lambda_url" {
  value = aws_lambda_function.whatsapp_webhook_lambda.invoke_arn
}
