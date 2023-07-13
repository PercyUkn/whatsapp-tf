# Create an S3 bucket for storing pipeline artifacts

resource "aws_s3_bucket" "pipeline_artifacts" {
  bucket        = "${local.app_name}-pipeline-artifacts" # Update with your desired S3 bucket name
  force_destroy = true
}

