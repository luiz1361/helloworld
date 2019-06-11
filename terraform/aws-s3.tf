resource "aws_s3_bucket" "apps_bucket" {
    bucket = "aksjdajsd10dj91j0d101dj"
    acl = "private"
    versioning {
            enabled = true
    }
    force_destroy = true
}