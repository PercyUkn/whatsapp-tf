# Create an S3 bucket for storing pipeline artifacts
resource "aws_s3_bucket" "pipeline_artifacts" {
  bucket        = "whatsapp-server-artifacts" # Update with your desired S3 bucket name
  force_destroy = true
}

# Bucket para las sesiones de WhatsApp (whatsapp-web.js)
resource "aws_s3_bucket" "whatsapp_sessions" {
  bucket        = "whatsapp-sessions-unique-tf" # Update with your desired S3 bucket name
  force_destroy = true
}
