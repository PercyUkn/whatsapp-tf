# Create an IAM role for the CodePipeline pipeline

resource "aws_iam_role" "whatsapp_server_pipeline_role" {
  name = "${var.app_name}-pipeline-role" # Update with your desired IAM role name

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codepipeline.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
  })
}

resource "aws_iam_role_policy_attachment" "whatsapp_server_pipeline_policy_attachment" {
  policy_arn = aws_iam_policy.whatsapp_server_pipeline_policy.arn
  role       = aws_iam_role.whatsapp_server_pipeline_role.name
}


# Create an IAM role for the CodeBuild project

resource "aws_iam_role" "whatsapp_server_codebuild_role" {
  name = "${var.app_name}-codebuild-role" # Update with your desired IAM role name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codebuild.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.whatsapp_server_codebuild_role.name
  policy_arn = aws_iam_policy.whatsapp_server_codebuild_policy.arn
}


# Role para el task de ECS

resource "aws_iam_role" "whatsapp_server_ecs_task_role" {
  name               = "${var.app_name}-ecs-task-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "whatsapp_server_ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.whatsapp_server_ecs_task_role.name
  policy_arn = aws_iam_policy.whatsapp_server_ecs_task_execution_policy.arn
}


resource "aws_iam_role" "whatsapp_server_task_execution_role" {
  name               = "${var.app_name}-task-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "task_execution_policy_attachment" {
  role       = aws_iam_role.whatsapp_server_task_execution_role.name
  policy_arn = aws_iam_policy.whatsapp_server_task_execution_policy.arn
}
