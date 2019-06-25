resource "aws_efs_file_system" "efs-helloworld" {
  creation_token   = "efs-helloworld"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "false"
  tags = {
    Name = "efs-helloworld"
  }
}

resource "aws_efs_mount_target" "efs-mt-helloworld" {
  count           = "${length(var.subnets_cidr)}"
  file_system_id  = "${aws_efs_file_system.efs-helloworld.id}"
  subnet_id       = "${element(aws_subnet.public.*.id, count.index)}"
  security_groups = ["${aws_security_group.efs-sg.id}"]
}