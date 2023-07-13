resource "aws_security_group" "whatsapp_server_security_group" {
  name        = "${local.app_name}-security-group-tf"
  description = "Security group para ${local.app_name} creado mediante Terraform"

  //TODO: Restringir el tráfico para salida solo a 3001
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
