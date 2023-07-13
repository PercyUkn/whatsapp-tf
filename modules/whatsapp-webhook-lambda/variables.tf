variable "aws_region" {
  type    = string
  default = "us-east-1" # Replace with your desired AWS region
}

variable "app_name" {
  type    = string
  default = "whatsapp-webhook"
}

variable "aws_access_key_id" {
  type        = string
  description = "El AK que toma el Docker de codebuild para iniciar sesión en AWS y usar ECR"
}


variable "aws_secret_access_key" {
  type        = string
  description = "El SK que toma el Docker de codebuild para iniciar sesión en AWS y usar ECR"
}

variable "whatsapp_webhook_token" {
  type        = string
  description = "Token para registrar el webhook"
}

variable "whatsapp_server_url" {
  type        = string
  description = "La URL del servidor de WhatsApp para reenviar los mensajes"
}
