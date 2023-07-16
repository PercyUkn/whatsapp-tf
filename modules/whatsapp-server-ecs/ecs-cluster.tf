resource "aws_ecs_cluster" "whatsapp_server_ecs_cluster" {
  name = "${var.app_name}-cluster-tf"
}


resource "aws_ecs_cluster_capacity_providers" "whatsapp_server_ecs_cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.whatsapp_server_ecs_cluster.name

  capacity_providers = ["FARGATE","FARGATE_SPOT"]


  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }

}
