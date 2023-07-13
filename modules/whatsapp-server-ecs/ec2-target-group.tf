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
