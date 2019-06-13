resource "aws_launch_configuration" "app" {
  image_id = "${var.ami}"
  instance_type = "${var.ec2_instance_type}"
  key_name               = "${aws_key_pair.ssh.id}"
  security_groups = ["${aws_security_group.asg.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.app_instance_profile.id}"
  user_data = "${file("bootstrap.sh")}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
   
  launch_configuration = "${aws_launch_configuration.app.id}"
  availability_zones = "${data.aws_availability_zones.all.names}"
  min_size = "${var.asg_min}"
  max_size = "${var.asg_max}"

  load_balancers = ["${aws_elb.app.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "terraform-asg-app"
    propagate_at_launch = true
  }
}