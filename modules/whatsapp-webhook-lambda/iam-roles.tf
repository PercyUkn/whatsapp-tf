resource "aws_iam_role" "whatsapp_webhook_lambda_role" {
  name = "my-lambda-role" # Update with your desired IAM role name

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

resource "aws_iam_policy" "whatsapp_webhook_lambda_policy" {
  name        = "my-lambda-policy" # Update with your desired policy name
  description = "Basic policy for Lambda function"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "lambda:InvokeFunction",
        "Resource" : "arn:aws:lambda:*:*:function:${aws_lambda_function.whatsapp_webhook_lambda.function_name}"
      },
      {
        "Effect" : "Allow",
        "Action" : "logs:CreateLogGroup",
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:log-group:/aws/lambda/${aws_lambda_function.whatsapp_webhook_lambda.function_name}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "whatsapp_webhook_policy_attachment" {
  policy_arn = aws_iam_policy.whatsapp_webhook_lambda_policy.arn
  role       = aws_iam_role.whatsapp_webhook_lambda_role.name
}




# Create an IAM role for the CodePipeline pipeline

resource "aws_iam_role" "whatsapp_webhook_pipeline_role" {
  name = "my-pipeline-role" # Update with your desired IAM role name

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

resource "aws_iam_policy" "whatsapp_webhook_pipeline_policy" {
  name        = "my-pipeline-policy" # Update with your desired policy name
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
        "Resource" : "arn:aws:codecommit:*:*:${aws_codecommit_repository.whatsapp_webhook.repository_name}"
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
        "Resource" : "${aws_ecr_repository.whatsapp_webhook.arn}"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:UpdateFunctionCode",
          "lambda:GetFunction"
        ],
        "Resource" : "arn:aws:lambda:*:*:function:${aws_lambda_function.whatsapp_webhook_lambda.function_name}"
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
        "Resource" : aws_codebuild_project.whatsapp_webhook_codebuild_project.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "whatsapp_webhook_pipeline_policy_attachment" {
  policy_arn = aws_iam_policy.whatsapp_webhook_pipeline_policy.arn
  role       = aws_iam_role.whatsapp_webhook_pipeline_role.name
}

# Create an IAM role for the CodeBuild project

resource "aws_iam_role" "my_codebuild_role" {
  name = "my-codebuild-role" # Update with your desired IAM role name

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

# Attach necessary policies to the role for CodeBuild execution

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

resource "aws_iam_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.my_codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}
