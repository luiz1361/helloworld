provider "cloudflare" {
  version = "~> 1.15"
}

provider "aws" {
  version = "~> 2.14"
  region  = "${var.aws_region}"
}
