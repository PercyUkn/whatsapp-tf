data "aws_caller_identity" "current" {}

# Create a CodeBuild project for building the Docker image

resource "aws_codebuild_project" "whatsapp_webhook_codebuild_project" {
  name         = "${local.app_name}-project" # Update with your desired project name
  service_role = aws_iam_role.whatsapp_webhook_codebuild_role.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "ECR_REPO_NAME"
      value = aws_ecr_repository.whatsapp_webhook.repository_url
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
  }
  source {
    type = "CODEPIPELINE"
    buildspec = templatefile("${path.module}/buildspec.yml",
      {
        ecr_repo_name         = aws_ecr_repository.whatsapp_webhook.repository_url,
        AWS_REGION            = local.aws_region[local.env],
        AWS_ACCOUNT_ID        = data.aws_caller_identity.current.account_id,
        lambda_name           = aws_lambda_function.whatsapp_webhook_lambda.function_name,
        aws_access_key_id     = local.aws_access_key_id[local.env],
        aws_secret_access_key = local.aws_secret_access_key[local.env]
      }
    )
    git_clone_depth = 1
  }
}
