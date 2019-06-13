#resource "aws_efs_file_system" "efs-app" {
#   creation_token = "efs-app"
#   performance_mode = "generalPurpose"
#   throughput_mode = "bursting"
#   encrypted = "false"
# tags = {
#     Name = "efs-app"
#   }
# }

# resource "aws_efs_mount_target" "efs-mt-app" {
#   file_system_id  = "${aws_efs_file_system.efs-app.id}"
#   subnet_id = "${aws_subnet.public.id}"
#   security_groups = ["${aws_security_group.efs-sg.id}"]
# }