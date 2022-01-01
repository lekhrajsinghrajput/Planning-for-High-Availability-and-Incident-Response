resource "aws_lb_target_group" "test-tg" {
  name     = "tf-lb-tg-zone2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb" "alb01" {
  name                       = "elb-zone2"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = true
  security_groups            = ["${var.security_groups}"]
  subnets                    = "${var.alb_subnets}"
}

resource "aws_lb_target_group_attachment" "test-attachment" {
  target_group_arn = aws_lb_target_group.test-tg.arn
  count            = length(var.instance_ids)
  target_id        = var.instance_ids[count.index].id
  port             = 80
}

resource "aws_lb_listener" "alb_lb_listener01" {
  load_balancer_arn = "${aws_lb.alb01.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-tg.arn
  }
}

