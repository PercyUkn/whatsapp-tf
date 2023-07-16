resource "aws_cloudwatch_event_rule" "whatsapp_server_commit_event_rule" {
  name        = "${var.app_name}-event-rule-codeCommit"
  description = "CodeCommit Repository State Change Event Rule for ${var.app_name}"

  event_pattern = <<PATTERN
{
  "source": ["aws.codecommit"],
  "detail-type": ["CodeCommit Repository State Change"],
  "resources": ["arn:aws:codecommit:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_codecommit_repository.whatsapp_server.repository_name}"],
  "detail": {
    "event": ["referenceCreated", "referenceUpdated"],
    "referenceType": ["branch"],
    "referenceName": ["master"]
  }
}
PATTERN
}


resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.whatsapp_server_commit_event_rule.name
  target_id = "codepipeline-${var.app_name}Pipeline"

  arn      = "arn:aws:codepipeline:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_codepipeline.whatsapp_server_pipeline.name}"
  role_arn = aws_iam_role.whatsapp_server_event_role.arn
}
