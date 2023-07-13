resource "aws_codepipeline" "whatsapp_webhook_pipeline" {
  name     = "${local.app_name}-pipeline-tf" # Update with your desired pipeline name
  role_arn = aws_iam_role.whatsapp_server_pipeline_role.arn

  # Pipeline stages and actions

  artifact_store {
    location = aws_s3_bucket.pipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = aws_codecommit_repository.whatsapp_server.repository_name
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.whatsapp_server_codebuild_project.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployAction"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName       = aws_ecs_cluster.whatsapp_server_ecs_cluster.name
        ServiceName       = aws_ecs_service.whatsapp_server_ecs_service.name
        FileName          = "imagedefinitions.json"
        DeploymentTimeout = "10" # Update with the desired deployment timeout value
      }
    }
  }

}
