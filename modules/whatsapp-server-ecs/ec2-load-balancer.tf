data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [local.load_balancer_vpc_id[local.env]]
  }
}


resource "aws_lb" "whatsapp_server_alb" {
  name               = "${local.app_name}-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.whatsapp_server_security_group.id]
  // Se crea el load balancer disponible para cada subnet de la VPC
  subnets = data.aws_subnets.vpc_subnets.ids


  tags = {
    CreatedBy = "Terraform"
  }
}
