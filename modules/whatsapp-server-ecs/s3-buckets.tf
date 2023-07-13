# Create an S3 bucket for storing pipeline artifacts
resource "aws_s3_bucket" "pipeline_artifacts" {
  bucket        = "${var.app_name}-artifacts" # Update with your desired S3 bucket name
  force_destroy = true
}

# Bucket para las sesiones de WhatsApp (whatsapp-web.js)
resource "aws_s3_bucket" "whatsapp_sessions" {
  bucket        = "${var.app_name}-unique-tf" # Update with your desired S3 bucket name
  force_destroy = true
}

# Folder para el bucket de S3
resource "aws_s3_object" "whatsapp_sessions_folder" {
  bucket = aws_s3_bucket.whatsapp_sessions.id
  key    = "${var.app_name}-sessions-folder/"

  content_type = "application/x-directory"
}
