// TODO: Obtener el AK y SK desde AWS KMS.

// Credenciales de AWS para el docker que usa Codebuild

variable "aws_access_key_id" {
  type        = string
  description = "El AK que toma el Docker de codebuild para iniciar sesión en AWS y usar ECR"
}

variable "aws_secret_access_key" {
  type        = string
  description = "El SK que toma el Docker de codebuild para iniciar sesión en AWS y usar ECR"
}


variable "whatsapp_webhook_token" {
  type = string
}

variable "email_subscriber" {
  type        = string
  description = "Email que se va a suscribir a las notificaciones de sesión mediante SNS"
}

variable "load_balancer_vpc_id" {
  type        = string
  description = "El ID de la VPC dónde se desplegará el load balancer"
}


variable "imgur_client_id" {
  type        = string
  description = "ID del cliente de IMGUR para subir el QR"
}

variable "meta_id_number" {
  type        = string
  description = "ID del número de Meta"
}

variable "meta_token" {
  type        = string
  description = "Permanent token de Meta"
}

variable "webhook_token" {
  type        = string
  description = "Token para registrar el webhook"
}

variable "cantidad_clientes_iniciales" {
  type        = string
  description = "Cantidad de clientes de WhatsApp para whatsapp-web.js"
}
