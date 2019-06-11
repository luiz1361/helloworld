provider "cloudflare" {
}

resource "cloudflare_record" "helloworld" {
  domain  = "${var.domain}"
  name    = "helloworld"
  value   = "${aws_elb.example.dns_name}"
  type    = "CNAME"
  proxied = true
}
