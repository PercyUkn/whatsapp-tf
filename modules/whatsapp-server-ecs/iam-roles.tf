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
