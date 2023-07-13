resource "aws_lb_listener" "whatsapp_server_listener" {
  load_balancer_arn = aws_lb.whatsapp_server_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.whatsapp-server-alb-tg.arn
    type             = "forward"
  }
}
