data "aws_caller_identity" "current" {}

# Create a CodeBuild project for building the Docker image

resource "aws_codebuild_project" "whatsapp_server_codebuild_project" {
  name         = "${var.app_name}-project" # Update with your desired project name
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
        container_name        = "${var.app_name}-container"
        AWS_REGION            = var.aws_region,
        AWS_ACCOUNT_ID        = data.aws_caller_identity.current.account_id,
        aws_access_key_id     = var.aws_access_key_id,
        aws_secret_access_key = var.aws_secret_access_key
      }
    )
    git_clone_depth = 1
  }
}
