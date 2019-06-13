resource "aws_s3_bucket" "app_bucket" {
    bucket = "${var.bucketname}"
    acl = "private"
    versioning {
            enabled = true
    }
    force_destroy = true
}
