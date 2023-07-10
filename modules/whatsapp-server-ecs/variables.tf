variable "aws_region" {
  type    = string
  default = "us-east-1" # Replace with your desired AWS region
}

variable "app_name" {
  type    = string
  default = "whatsapp-server"
}

variable "email_subscriber" {
  type = string
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}

variable "whatsapp_webhook_token" {
  type = string
}
