output "elb_dns_name" {
  value = "${aws_elb.helloworld.dns_name}"
}
