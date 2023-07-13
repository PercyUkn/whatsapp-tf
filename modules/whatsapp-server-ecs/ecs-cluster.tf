resource "aws_ecs_cluster" "whatsapp_server_ecs_cluster" {
  name = "${local.app_name}-cluster-tf"
}
