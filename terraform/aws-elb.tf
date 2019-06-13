resource "aws_elb" "app" {
  name = "terraform-elb-app"
  availability_zones = "${data.aws_availability_zones.all.names}"
  security_groups = ["${aws_security_group.elb.id}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 5
    target = "HTTP:${var.app_port}/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.app_port}"
    instance_protocol = "http"
  }
}