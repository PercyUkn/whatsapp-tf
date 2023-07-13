resource "aws_sns_topic" "session_restart_topic" {
  name = "${local.app_name}-notification-topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.session_restart_topic.arn
  protocol  = "email"
  endpoint  = local.email_subscriber[local.env]
}
