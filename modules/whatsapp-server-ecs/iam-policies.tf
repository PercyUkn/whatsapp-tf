resource "aws_iam_policy" "whatsapp_server_pipeline_policy" {
  name        = "${var.app_name}-pipeline-policy" # Update with your desired policy name
  description = "Basic policy for CodePipeline pipeline"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "codecommit:Get*",
          "codecommit:List*",
          "codecommit:GitPull",
          "codecommit:CancelUploadArchive",
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GetRepository",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:UploadArchive"
        ],
        "Resource" : "arn:aws:codecommit:*:*:${aws_codecommit_repository.whatsapp_server.repository_name}"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ],
        "Resource" : aws_ecr_repository.whatsapp_server.arn
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.pipeline_artifacts.id}/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.pipeline_artifacts.id}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ],
        "Resource" : aws_codebuild_project.whatsapp_server_codebuild_project.arn
      },
    ]
  })
}


data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "whatsapp_server_codebuild_policy" {
  name   = "${var.app_name}-codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy.json
}



data "aws_iam_policy_document" "ecs_task_execution_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "s3-object-lambda:*"
    ]
    resources = [aws_s3_bucket.whatsapp_sessions.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "sns:*"
    ]
    resources = [aws_sns_topic.session_restart_topic.arn]
  }
}

resource "aws_iam_policy" "whatsapp_server_ecs_task_execution_policy" {
  name   = "${var.app_name}-ecs-task-execution-policy"
  policy = data.aws_iam_policy_document.ecs_task_execution_policy.json
}


resource "aws_iam_policy" "whatsapp_server_task_execution_policy" {
  name        = "${var.app_name}-task-execution-policy"
  description = "Task Execution Role Policy para la tarea de ${var.app_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
