resource "aws_launch_configuration" "helloworld" {
  image_id             = "${var.ami}"
  instance_type        = "${var.ec2_instance_type}"
  key_name             = "${aws_key_pair.ssh.id}"
  security_groups      = ["${aws_security_group.asg.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.helloworld_instance_profile.id}"
  user_data            = <<-EOF
    #!/bin/bash -xe
    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
    sudo echo "Hello, World" > index.html
    sudo nohup busybox httpd -f -p "${var.busybox_port}" &
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip nfs-common apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io 
    sudo pip3 install awscli
    sudo mkdir /efs
    sudo chown -R ubuntu /efs
    for z in {0..300}; do
     sudo echo .
     sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${aws_efs_file_system.efs-helloworld.dns_name}:/ /efs && break
     sudo sleep 1
    done
    sleep $[ ( $RANDOM % 10 )  + 1 ]s
    if `sudo aws s3 cp s3://"${var.bucketname}"/swarm_manager_token /`; then
      sudo bash /swarm_manager_token
    else
     sudo docker swarm init
     sudo docker swarm join-token manager | grep token > /swarm_manager_token
     sudo aws s3 cp /swarm_manager_token s3://"${var.bucketname}"/
    fi
    sudo docker run -p "${var.helloworld_port}":80 -d "${var.helloworld_docker_image}"
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "helloworld" {
  launch_configuration = "${aws_launch_configuration.helloworld.id}"
  vpc_zone_identifier = "${aws_subnet.public.*.id}"
  min_size = "${var.asg_min}"
  max_size = "${var.asg_max}"
  load_balancers = ["${aws_elb.helloworld.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "asg-helloworld"
    propagate_at_launch = true
  }
}