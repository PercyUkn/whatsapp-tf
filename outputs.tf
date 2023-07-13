output "whatsapp_webhook_lambda_url" {
  value = module.whatsapp-webhook-lambda.lambda_url
}

output "whatsapp_lambda_repo_url" {
  value = module.whatsapp-webhook-lambda.lambda_cc_repo_url
}

output "whatsapp_server_repo_url" {
  value = module.whatsapp-server-ecs.whatsapp_server_repo
}

output "whatsapp_server_lb_url" {
  value = module.whatsapp-server-ecs.whatsapp_server_lb_dns_name
}
