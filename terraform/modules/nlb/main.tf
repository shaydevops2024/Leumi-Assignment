resource "aws_lb" "nlb" {
  name               = var.nlb_name
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    protocol = var.health_check_protocol
    port     = var.health_check_port
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.target_id
  port             = var.tg_port
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

