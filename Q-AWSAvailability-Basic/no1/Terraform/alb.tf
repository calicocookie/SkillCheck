resource "aws_lb" "app" {
  name               = "app"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.app_alb.id,
  ]

  subnets = [aws_subnet.public_c.id, aws_subnet.public_d.id]
}

resource "aws_lb_target_group" "app" {
  name = "app"

  health_check {
    protocol = "HTTP"
    matcher  = "200"
    timeout  = "45"
    path     = "/"
  }

  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn

  port            = "443"
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = var.app_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.app.arn
    type             = "forward"
  }
}
