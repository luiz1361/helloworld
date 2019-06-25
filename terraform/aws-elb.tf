resource "aws_elb" "helloworld" {
  name            = "elb-helloworld"
  subnets         = "${aws_subnet.public.*.id}"
  security_groups = ["${aws_security_group.elb.id}"]
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 5
    target              = "HTTP:${var.helloworld_port}/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.helloworld_port}"
    instance_protocol = "http"
  }
}