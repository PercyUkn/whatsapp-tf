output "whatsapp_webhook_url" {
  value = module.whatsapp-webhook-lambda.lambda_url
}

output "whatsapp_server_repo_url" {
  value = module.whatsapp-server-ecs.whatsapp_server_repo
}
