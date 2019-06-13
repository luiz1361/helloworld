resource "aws_iam_role" "app_iam_role" {
    name = "app_iam_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "app_instance_profile" {
    name = "app_instance_profile"
    role = "${aws_iam_role.app_iam_role.name}"
}

resource "aws_iam_role_policy" "app_iam_role_policy" {
  name = "app_iam_role_policy"
  role = "${aws_iam_role.app_iam_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::aksjdajsd10dj91j0d101dj"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::aksjdajsd10dj91j0d101dj/*"]
    }
  ]
}
EOF
}
