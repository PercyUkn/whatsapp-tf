resource "aws_iam_role" "whatsapp_webhook_lambda_role" {
  name = "${var.app_name}-lambda-role" # Update with your desired IAM role name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    "createdBy" : "Terraform"
  }
}


resource "aws_iam_role_policy_attachment" "whatsapp_webhook_policy_attachment" {
  policy_arn = aws_iam_policy.whatsapp_webhook_lambda_policy.arn
  role       = aws_iam_role.whatsapp_webhook_lambda_role.name
}




# Create an IAM role for the CodePipeline pipeline

resource "aws_iam_role" "whatsapp_webhook_pipeline_role" {
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


resource "aws_iam_role_policy_attachment" "whatsapp_webhook_pipeline_policy_attachment" {
  policy_arn = aws_iam_policy.whatsapp_webhook_pipeline_policy.arn
  role       = aws_iam_role.whatsapp_webhook_pipeline_role.name
}

# Create an IAM role for the CodeBuild project

resource "aws_iam_role" "whatsapp_webhook_codebuild_role" {
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
  role       = aws_iam_role.whatsapp_webhook_codebuild_role.name
  policy_arn = aws_iam_policy.whatsapp_webhook_codebuild_policy.arn
}


resource "aws_iam_role" "whatsapp_webhook_event_role" {
  name = "${var.app_name}-event-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      "Principal" : {
        "Service" : "events.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })

  path = "/"

  tags = {
    Name = "EventRole"
  }
}
