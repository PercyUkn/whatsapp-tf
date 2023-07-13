data "aws_caller_identity" "current" {}

# Create a CodeBuild project for building the Docker image

resource "aws_codebuild_project" "whatsapp_server_codebuild_project" {
  name         = "${local.app_name}-project" # Update with your desired project name
  service_role = aws_iam_role.whatsapp_server_codebuild_role.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }
  source {
    type = "CODEPIPELINE"
    buildspec = templatefile("${path.module}/buildspec.yml",
      {
        ecr_repo_name         = aws_ecr_repository.whatsapp_server.repository_url,
        container_name        = "${local.app_name}-container"
        AWS_REGION            = local.aws_region[local.env],
        AWS_ACCOUNT_ID        = data.aws_caller_identity.current.account_id,
        aws_access_key_id     = local.aws_access_key_id[local.env],
        aws_secret_access_key = local.aws_secret_access_key[local.env]
      }
    )
    git_clone_depth = 1
  }
}
