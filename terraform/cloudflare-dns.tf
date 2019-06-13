resource "cloudflare_record" "helloworld" {
  domain  = "${var.domain}"
  name    = "${var.app_dns_record}"
  value   = "${aws_elb.app.dns_name}"
  type    = "CNAME"
  proxied = true
}
