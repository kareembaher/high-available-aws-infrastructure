resource "aws_lb_target_group" "app-Target-Group-1" {
  health_check {
    interval            = 10
    path                = "/vpay"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "301,302"
  }
  name        = "app-tg"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.app.id

  stickiness {
    cookie_duration = 28800
    enabled         = true
    type            = "lb_cookie"
  }
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_lb_target_group_attachment" "ALB-TG-Attachment-1" {
  target_group_arn = aws_lb_target_group.app-Target-Group-1.arn
  target_id        = aws_instance.app-eu1-ec2-1.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "ALB-TG-Attachment-2" {
  target_group_arn = aws_lb_target_group.app-Target-Group-1.arn
  target_id        = aws_instance.app-eu1-ec2-2.id
  port             = 443
}

resource "aws_lb" "ALB" {
  name            = "alb"
  internal        = false
  security_groups = [aws_security_group.app-SG.id]
  subnets         = [aws_subnet.EU1-Pub1.id, aws_subnet.EU1-Pub2.id]
  tags = {
    Name = "alb"
  }
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  idle_timeout       = 4000
}

resource "aws_lb_listener" "ALB-Listner" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "ALB-Listner-SSL" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = aws_acm_certificate.ssl.arn
  default_action {
    target_group_arn = aws_lb_target_group.app-Target-Group-1.arn
    type             = "forward"
  }
}