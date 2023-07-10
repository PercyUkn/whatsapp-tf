output "whatsapp_server_repo" {
  value = {
    name = aws_codecommit_repository.whatsapp_server.repository_name
    url  = aws_codecommit_repository.whatsapp_server.clone_url_http
  }
}
