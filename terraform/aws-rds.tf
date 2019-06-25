/*resource "aws_db_instance" "helloworlddb" {
  identifier           = "helloworlddb"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.rds-subnet-gp.id}"
  allocated_storage    = "${var.rds_storage}"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "${var.rds_instance_type}"
  name                 = "helloworlddb"
  username             = "${var.rds_username}"
  password             = "${var.rds_password}"
  parameter_group_name = "default.mysql5.7"
  backup_retention_period = "7"
  final_snapshot_identifier = "dbfinalsnap"
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "rds-subnet-gp" {
    name = "rds-subnet-gp"
    subnet_ids = "${aws_subnet.public.*.id}"
}
*/