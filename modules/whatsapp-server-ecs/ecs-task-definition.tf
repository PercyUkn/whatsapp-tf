resource "aws_ecs_task_definition" "whatsapp_server_task_definition" {
  family                   = "${var.app_name}-task-definition-tf"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"

  task_role_arn = aws_iam_role.whatsapp_server_ecs_task_role.arn
  execution_role_arn = aws_iam_role.whatsapp_server_task_execution_role.arn

  network_mode = "awsvpc"

  runtime_platform {
    operating_system_family  = "LINUX"
    cpu_architecture         = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name : "${var.app_name}-container",
      image : "${aws_ecr_repository.whatsapp_server.name}:latest",
      // Verificar si es correcto cpu:0
      cpu : 0,
      portMappings : [
        {
          "name" : "${var.app_name}-3001-tcp-main",
          "containerPort" : 3001,
          "hostPort" : 3001,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      essential : true,
      environment : [
        {
          "name" : "BUCKET_NAME",
          "value" : aws_s3_bucket.whatsapp_sessions.id
        },
        {
          "name" : "FOLDER_NAME",
          "value" : aws_s3_object.whatsapp_sessions_folder.id
        },
        {
          "name" : "SNS_TOPIC_ARN",
          "value" : aws_sns_topic.session_restart_topic.arn
        },
        {
          "name" : "IMGUR_CLIENT_ID",
          "value" : var.imgur_client_id
        },
        {
          "name" : "META_ID_NUMBER",
          "value" : var.meta_id_number
        },
        {
          "name" : "META_TOKEN",
          "value" : var.meta_token
        },
        {
          "name" : "PORT",
          "value" : "3001"
        },
        {
          "name" : "WEBHOOK_TOKEN",
          "value" : var.webhook_token
        },
        {
          "name" : "CANTIDAD_CLIENTES_INICIALES",
          // TODO: Verificar si es correcto poner un número o string
          "value" : var.cantidad_clientes_iniciales
        }
      ],
      mountPoints : [],
      volumesFrom : [],
      logConfiguration : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/${var.app_name}-task-tf",
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}
