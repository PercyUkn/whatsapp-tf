resource "aws_ecs_service" "whatsapp_server_ecs_service" {
  name            = "${var.app_name}-service-tf"
  cluster         = aws_ecs_cluster.whatsapp_server_ecs_cluster.id
  task_definition = aws_ecs_task_definition.whatsapp_server_task_definition.family
  launch_type = "FARGATE"
  scheduling_strategy = "REPLICA"
  // TODO: Verificar si se parametriza
  desired_count = 1

  force_new_deployment = true


  load_balancer {
    target_group_arn = aws_lb_target_group.whatsapp-server-alb-tg.arn
    // Tiene que coincidir con el nombre del container en task definition:
    // https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/ecs_service#load_balancer
    container_name = "${var.app_name}-container"
    container_port = 3001
  }

  network_configuration {
    subnets          = data.aws_subnets.vpc_subnets.ids
    security_groups  = [aws_security_group.whatsapp_server_security_group.id]
    // OJO: Si no tiene public IP no funciona a menos que se cree o exista un NAT Gateway en la VPC
    // Pues se requiere conectividad hacia whatsapp-web.com
    // Además de conectividad hacia S3, ECR (API y DKR) y Cloudwatch Logs, estos pueden configurarse mediante
    // un VPC Endpoint interface
    assign_public_ip = true
  }

}
