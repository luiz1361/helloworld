#!/bin/bash

echo "Hello, World" > index.html

nohup busybox httpd -f -p "${var.busybox_port}" &

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

sudo docker swarm join-token manager | grep token > token.txt

aws s3 cp ./token.txt s3://aksjdajsd10dj91j0d101dj/

docker run -p "${var.app_port}":80 -d "${var.app_docker_image}"