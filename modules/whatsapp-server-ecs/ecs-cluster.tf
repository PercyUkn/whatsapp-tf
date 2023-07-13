resource "aws_ecs_cluster" "whatsapp_server_ecs_cluster" {
  name = "${var.app_name}-cluster-tf"
}
