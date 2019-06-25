resource "cloudflare_record" "helloworld" {
  domain  = "${var.domain}"
  name    = "${var.helloworld_dns_record}"
  value   = "${aws_elb.helloworld.dns_name}"
  type    = "CNAME"
  proxied = true
}
