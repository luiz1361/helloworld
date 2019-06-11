resource "aws_launch_configuration" "example" {
  image_id = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name               = "${aws_key_pair.ssh.id}"
  security_groups = ["${aws_security_group.instance.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.web_instance_profile.id}"
  user_data =   <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                cp "${file("~/.ssh/id_rsa")}" ~/.ssh/id_rsa
                sudo apt-get update
                sudo apt-get install -y \
                    apt-transport-https \
                    ca-certificates \
                    curl \
                    gnupg-agent \
                    software-properties-common
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo apt-key fingerprint 0EBFCD88
                sudo add-apt-repository \
                    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -cs) \
                    stable"
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io python3-pip
                sudo pip3 install awscli
                sudo docker swarm init
                sudo docker swarm join-token manager | grep token > token
                aws s3 cp ./token s3://aksjdajsd10dj91j0d101dj/
                EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  availability_zones = "${data.aws_availability_zones.all.names}"
  min_size = 1
  max_size = 1

  load_balancers = ["${aws_elb.example.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_elb" "example" {
  name = "terraform-asg-example"
  availability_zones = "${data.aws_availability_zones.all.names}"
  security_groups = ["${aws_security_group.elb.id}"]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 5
    target = "HTTP:${var.server_port}/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }
}