resource "aws_security_group" "asg" {
  name = "asg_sg"
  vpc_id      = "${aws_vpc.terra_vpc.id}"
  ingress {
    from_port = "${var.app_port}"
    to_port = "${var.app_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port = "${var.busybox_port}"
    to_port = "${var.busybox_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elb" {
  name = "elb-sg"
  vpc_id      = "${aws_vpc.terra_vpc.id}"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "efs-sg" {
   name = "efs-sg"
   vpc_id      = "${aws_vpc.terra_vpc.id}"

   ingress {
     cidr_blocks = ["0.0.0.0/0"]
     from_port = 2049
     to_port = 2049
     protocol = "tcp"
   }

   egress {
     cidr_blocks = ["0.0.0.0/0"]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }
 }