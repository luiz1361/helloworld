output "elb_dns_name" {
  value = "${aws_elb.app.dns_name}"
}
