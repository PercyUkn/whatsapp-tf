data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.load_balancer_vpc_id]
  }
}


resource "aws_lb" "whatsapp_server_alb" {
  name               = "${var.app_name}-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.whatsapp_server_security_group.id]
  // Se crea el load balancer disponible para cada subnet de la VPC
  subnets = data.aws_subnets.vpc_subnets.ids


  tags = {
    CreatedBy = "Terraform"
  }
}


resource "aws_lb_listener" "whatsapp_server_listener" {
  load_balancer_arn = aws_lb.whatsapp_server_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.whatsapp-server-alb-tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "whatsapp-server-alb-tg" {
  name        = "${var.app_name}-lb-alb-tg-tf"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.load_balancer_vpc_id
  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 30
    matcher = "200-499"
    path = "/"
    protocol = "HTTP"
  }
}
