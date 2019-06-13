resource "aws_db_instance" "appdb" {
  identifier           = "appdb"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "${var.rds_instance_type}"
  name                 = "appdb"
  username             = "${var.rds_username}"
  password             = "${var.rds_password}"
  parameter_group_name = "default.mysql5.7"
  backup_retention_period = "7"
  final_snapshot_identifier = "dbfinalsnap"
  skip_final_snapshot = true
}