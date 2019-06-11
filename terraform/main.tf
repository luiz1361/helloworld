data "aws_availability_zones" "all" {}

provider "aws" {
  region = "${var.aws_region}"
}